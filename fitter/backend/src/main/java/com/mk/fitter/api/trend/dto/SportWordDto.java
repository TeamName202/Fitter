package com.mk.fitter.api.trend.dto;

import com.mk.fitter.api.trend.entity.SportWord;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class SportWordDto {

	private String name;

	public SportWordDto(SportWord entity){
		this.name = entity.getName();
	}
}
