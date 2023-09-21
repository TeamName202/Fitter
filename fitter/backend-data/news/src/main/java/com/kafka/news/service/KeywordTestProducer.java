package com.kafka.news.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.SendResult;
import org.springframework.stereotype.Service;
import org.springframework.util.concurrent.ListenableFuture;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class KeywordTestProducer {
	private static final String TOPIC = "test-topic";
	private final KafkaTemplate<String, String> kafkaTestTemplate;

	Logger logger = LoggerFactory.getLogger(KeywordTestProducer.class);

	public void sendMessage(String message) { // 키워드 개별 전송
		ListenableFuture<SendResult<String, String>> future = kafkaTestTemplate.send(TOPIC, message);
		future.addCallback(sCallback -> {
			logger.info("Partition : {}, Offset : {}", sCallback.getRecordMetadata().partition(),
														sCallback.getRecordMetadata().offset());
		}, fCallback -> {
			logger.error("error msg : {}", fCallback.getMessage());
		});
	}












}
