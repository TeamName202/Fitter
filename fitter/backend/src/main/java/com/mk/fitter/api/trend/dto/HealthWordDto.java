package com.mk.fitter.api.trend.dto;

import com.mk.fitter.api.trend.entity.HealthWord;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class HealthWordDto {

	private String name;

	public HealthWordDto(HealthWord entity){
		this.name = entity.getName();
	}
}
