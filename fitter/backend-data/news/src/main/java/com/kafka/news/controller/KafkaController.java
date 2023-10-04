package com.kafka.news.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kafka.news.service.KeywordTestProducer;
import com.kafka.news.service.NewsWordProducer;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/kafka")
@RequiredArgsConstructor
public class KafkaController {

	private final KeywordTestProducer keywordTestProducer;

	private final NewsWordProducer newsWordProducer;
	@PostMapping("/test")
	public ResponseEntity<String> sendMessage(@RequestParam String message) {
		keywordTestProducer.sendMessage(message);
		return new ResponseEntity<>("메시지 보내기 실행 완료", HttpStatus.OK);
	}

	@PostMapping("/keyword")
	public ResponseEntity<String> sendNewsKeyword(){
		newsWordProducer.sendNewsKeyword();
		return new ResponseEntity<>("뉴스 키워드 보내기 실행 완료", HttpStatus.OK);
	}


}

