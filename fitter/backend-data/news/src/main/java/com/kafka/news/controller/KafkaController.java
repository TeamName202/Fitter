package com.kafka.news.controller;

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
	public void sendMessage(@RequestParam String message) {
		keywordTestProducer.sendMessage(message);
	}

	@PostMapping("/keyword")
	public void sendNewsKeyword(){
		newsWordProducer.sendNewsKeyword();
	}


}

