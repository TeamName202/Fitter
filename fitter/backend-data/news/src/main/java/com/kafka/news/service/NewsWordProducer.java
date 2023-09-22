package com.kafka.news.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kafka.news.repository.HealthWordRepository;
import com.kafka.news.repository.SportsWordRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NewsWordProducer {

	private final KafkaTemplate<String, String> kafkaSports;
	private final KafkaTemplate<String, String> kafkaHealth;

	private final HealthWordRepository healthWordRepository;
	private final SportsWordRepository sportsWordRepository;

	@Value("${spring.crawler.csv.folder}")
	private String path;

	Logger logger = LoggerFactory.getLogger(NewsWordProducer.class);

	@Scheduled(cron = "0 10 0 * * ?") // 정오 자동 실행
	@Transactional
	public void sendNewsKeyword(){
		healthWordRepository.deleteAll();
		sportsWordRepository.resetCountToZero();
		sendSportsWord(kafkaSports);
		sendHealthWord(kafkaHealth);
	}

	private void sendSportsWord(KafkaTemplate<String, String> kafkaTemplate) {
		List<String> sportsNewsNames = Arrays.asList("NaverSportsNews", "JoongangSportsNews",
			"DongaSportsNews", "ChosunSportsNews");

		sendNewsWords(kafkaTemplate, "sports", "sports-topic", sportsNewsNames);
	}

	private void sendHealthWord(KafkaTemplate<String, String> kafkaTemplate) {
		List<String> healthNewsNames = Arrays.asList("ChosunHealthNews", "DongaHealthNews",
			"JoongangHealthNews", "NaverHealthNews");

		sendNewsWords(kafkaTemplate, "health", "health-topic",healthNewsNames);
	}

	private void sendNewsWords(KafkaTemplate<String, String> kafkaTemplate, String type, String topic,
		List<String> newsNames) {
		ExecutorService executorService = Executors.newFixedThreadPool(newsNames.size());
		List<CompletableFuture<Void>> futures = new ArrayList<>();

		for (String newsName : newsNames) {
			CompletableFuture<Void> future = CompletableFuture.runAsync(() ->
				sendNewsData(kafkaTemplate, newsName, type, topic), executorService);
			futures.add(future);
		}

		// 모든 작업이 완료될 때까지 대기
		CompletableFuture<Void> allOf = CompletableFuture.allOf(futures.toArray(new CompletableFuture[0]));

		try {
			allOf.get(); // 모든 작업이 완료될 때까지 대기
			executorService.shutdown(); // 스레드 풀 종료
			if (!executorService.awaitTermination(5, TimeUnit.SECONDS)) { // 최대 5초까지 스레드 풀 종료 기다림
				executorService.shutdownNow(); // 시간 초과 시 강제 종료
			}
		} catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
			Thread.currentThread().interrupt(); // 인터럽트 상태 복원
		} finally {
			if (!executorService.isTerminated()) {
				executorService.shutdownNow(); // 아직 완전히 종료되지 않았으면 강제 종료
			}
		}
	}

	private void sendNewsData(KafkaTemplate<String, String> kafkaTemplate, String newsName, String type, String topic) {
		String yesterday = LocalDate.now().minusDays(1).format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		File csv = new File(path + "\\" + type + "\\" + newsName + yesterday + ".csv");

		if (!csv.exists()){
			logger.info("뉴스 파일이 존재하지 않습니다. {}", csv.getPath());
			return;
		}

		try (BufferedReader br = new BufferedReader(new FileReader(csv))) {
			String line;
			while ((line = br.readLine()) != null) {
				if (line.isEmpty())
					continue;
				String[] split = line.split(";");
				if (split.length > 2) {
					kafkaTemplate.send(topic, split[2]);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
