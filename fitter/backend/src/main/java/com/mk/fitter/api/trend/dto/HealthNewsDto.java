package com.mk.fitter.api.trend.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class HealthNewsDto {

	private String title;
	private String link;

	@Builder
	public HealthNewsDto(String title, String link){
		this.title = title;
		this.link = link;
	}
}
