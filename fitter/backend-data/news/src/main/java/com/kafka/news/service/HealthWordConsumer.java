package com.kafka.news.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kafka.news.entity.HealthWord;
import com.kafka.news.repository.HealthWordRepository;

import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HealthWordConsumer {

	private final HealthWordRepository healthWordRepository;
	private static final String TOPIC = "health-topic";
	private static final ConcurrentMap<String, Integer> healthCountMap = new ConcurrentHashMap<>();

	Logger logger = LoggerFactory.getLogger(HealthWordConsumer.class);

	@KafkaListener(topics = TOPIC, groupId = "health-keyword", concurrency = "3")
	public void receiveMessage(String message) throws IOException {
		Komoran komoran = new Komoran(DEFAULT_MODEL.LIGHT);
		message = message.strip();
		KomoranResult analyze = komoran.analyze(message);
		List<String> nouns = analyze.getMorphesByTags("NNG", "NNP");
		for(String noun : nouns) {
			healthCountMap.compute(noun, (key, value) -> value == null ? 1 : value + 1);
		}
	}

	@Scheduled(fixedDelay = 60000)
	public void saveToDB() {
		for (Map.Entry<String, Integer> entry : healthCountMap.entrySet()) {
			String word = entry.getKey();
			Integer count = entry.getValue();

			Optional<HealthWord> healthWord = healthWordRepository.findByName(word);

			if (healthWord.isPresent()) {
				HealthWord existingHealthWord = healthWord.get();
				existingHealthWord.updateCount(count);
				healthWordRepository.save(existingHealthWord);
				logger.info("update health-keyword: {}, count: {}", word, count);
			} else {
				HealthWord newHealthWord = HealthWord.builder()
					.name(word)
					.count(count)
					.build();
				healthWordRepository.save(newHealthWord);
				logger.info("new health-keyword: {}", word);
			}
		}
		healthCountMap.clear();
	}
}
