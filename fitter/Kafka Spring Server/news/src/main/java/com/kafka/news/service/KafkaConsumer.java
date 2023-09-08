package com.kafka.news.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KafkaConsumer {
	private static final String TOPIC = "keyword";

	@KafkaListener(topics = TOPIC, groupId = "keywordCount", concurrency = "10")
	public void receiveMessage(String message) throws IOException {
		Komoran komoran = new Komoran(DEFAULT_MODEL.LIGHT);
		message = message.strip();
		KomoranResult analyze = komoran.analyze(message);
		List<String> nouns = analyze.getNouns();
		// 명사 개수 세기
		Map<String, Integer> wordCountMap = new HashMap<>();
		for (String noun : nouns) {
			wordCountMap.put(noun, wordCountMap.getOrDefault(noun, 0) + 1);
		}
		System.out.println(wordCountMap);
	}
}
