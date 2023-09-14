package com.kafka.news.controller;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kafka.news.service.KafkaProducer;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/kafka")
@RequiredArgsConstructor
public class KafkaController {

	private final KafkaProducer kafkaProducer;

	@PostMapping("/producer")
	public void sendMessage(@RequestParam String message) {
		kafkaProducer.sendMessage(message);
	}

	@PostMapping("/keyword")
	public void sendKeyword() throws Exception {
		ExecutorService executorService = Executors.newFixedThreadPool(4); // 병렬로 처리할 스레드 풀 생성

		CompletableFuture<Void> chosunFuture = CompletableFuture.runAsync(kafkaProducer::sendChosun, executorService);
		CompletableFuture<Void> dongaFuture = CompletableFuture.runAsync(kafkaProducer::sendDonga, executorService);
		CompletableFuture<Void> joongangFuture = CompletableFuture.runAsync(kafkaProducer::sendJoongang,
			executorService);
		CompletableFuture<Void> naverFuture = CompletableFuture.runAsync(kafkaProducer::sendNaver, executorService);

		// 모든 작업이 완료될 때까지 대기
		CompletableFuture<Void> allOf = CompletableFuture.allOf(chosunFuture, dongaFuture, joongangFuture, naverFuture);

		try {
			allOf.get(); // 모든 작업이 완료될 때까지 대기
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			executorService.shutdown(); // 스레드 풀 종료
			try {
				executorService.awaitTermination(5, TimeUnit.SECONDS); // 종료될 때까지 최대 5초 대기
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}

}

