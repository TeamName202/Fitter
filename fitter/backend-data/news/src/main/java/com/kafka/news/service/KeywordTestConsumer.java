package com.kafka.news.service;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

import kr.co.shineware.nlp.komoran.constant.DEFAULT_MODEL;
import kr.co.shineware.nlp.komoran.core.Komoran;
import kr.co.shineware.nlp.komoran.model.KomoranResult;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KeywordTestConsumer {

	private static final String TOPIC = "test-topic";

	private final KafkaTemplate<String, String> kafkaTestTemplate;

	Logger logger = LoggerFactory.getLogger(KeywordTestConsumer.class);

	@KafkaListener(topics = TOPIC, groupId = "keyword-test")
	public void receiveMessage(String message) throws IOException {
		Komoran komoran = new Komoran(DEFAULT_MODEL.LIGHT);
		message = message.strip();
		KomoranResult analyze = komoran.analyze(message);
		List<String> nouns = analyze.getNouns();
		for (String noun : nouns) {
			logger.info("word : {}", noun);
		}
	}


}

