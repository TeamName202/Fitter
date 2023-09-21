package com.kafka.news.service;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kafka.news.entity.SportsWord;
import com.kafka.news.repository.SportsWordRepository;

import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SportsWordConsumer {

	private final SportsWordRepository sportsWordRepository;
	private static final String TOPIC = "sports-topic";
	private static final ConcurrentMap<String, Integer> sportsCountMap = new ConcurrentHashMap<>();

	Logger logger = LoggerFactory.getLogger(SportsWordConsumer.class);
	private Set<String> sportSet = new HashSet<>();
	@PostConstruct
	public void init() {
		sportSet = sportsWordRepository.findAllNames();
	}

	@KafkaListener(topics = TOPIC, groupId = "sports-keyword", concurrency = "3")
	public void receiveMessage(String message) throws IOException {
		Komoran komoran = new Komoran(DEFAULT_MODEL.LIGHT);
		message = message.strip();
		KomoranResult analyze = komoran.analyze(message);
		List<String> nouns = analyze.getMorphesByTags("NNG", "NNP");
		for(String noun : nouns) {
			if (isSportsKeyword(noun)) {
				sportsCountMap.compute(noun, (key, value) -> value == null ? 1 : value + 1);
			}
		}
	}

	private boolean isSportsKeyword(String message) {
		return sportSet.contains(message);
	}

	@Scheduled(fixedDelay = 60000)
	public void saveToDB() {
		for (Map.Entry<String, Integer> entry : sportsCountMap.entrySet()) {
			String word = entry.getKey();
			Integer count = entry.getValue();

			Optional<SportsWord> sportsWord = sportsWordRepository.findByName(word);

			if (sportsWord.isPresent()) {
				SportsWord existingSportsWord = sportsWord.get();
				existingSportsWord.updateCount(count);
				sportsWordRepository.save(existingSportsWord);
				logger.info("update sport-keyword: {}, count: {}", word, count);
			} else {
				SportsWord newSportsWord = SportsWord.builder()
					.name(word)
					.count(count)
					.build();
				sportsWordRepository.save(newSportsWord);
				logger.info("new sport-keyword: {}", word);
			}
		}
		sportsCountMap.clear();
	}
}
