package com.kafka.news.dto;

import com.kafka.news.entity.SportWord;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class SportWordDto {

	private String name;
	private int count;

	public SportWordDto(SportWord entity){
		this.name = entity.getName();
		this.count = entity.getCount();
	}
}
