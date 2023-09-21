package com.mk.fitter.api.trend.dto;

import com.mk.fitter.api.trend.entity.SportsWord;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class SportsWordDto {

	private String name;

	public SportsWordDto(SportsWord entity){
		this.name = entity.getName();
	}
}
