package com.kafka.news.dto;

import com.kafka.news.entity.HealthWord;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class HealthWordDto {

	private String name;
	private int count;

	public HealthWordDto(HealthWord entity){
		this.name = entity.getName();
		this.count = entity.getCount();
	}
}
