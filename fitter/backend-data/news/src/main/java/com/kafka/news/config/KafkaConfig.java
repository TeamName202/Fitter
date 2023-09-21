package com.kafka.news.config;

import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.config.TopicBuilder;

@Configuration
public class KafkaConfig {

	@Bean
	public NewTopic testTopic() {
		return TopicBuilder.name("test-topic")
			.partitions(3)
			.replicas(1)
			.build();
	}
	@Bean
	public NewTopic sportsTopic() {
		return TopicBuilder.name("sports-topic")
			.partitions(3)
			.replicas(1)
			.build();
	}

	@Bean
	public NewTopic healthTopic() {
		return TopicBuilder.name("health-topic")
			.partitions(3)
			.replicas(1)
			.build();
	}
}



