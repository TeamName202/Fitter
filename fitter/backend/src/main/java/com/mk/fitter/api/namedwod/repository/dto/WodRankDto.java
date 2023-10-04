package com.mk.fitter.api.namedwod.repository.dto;

import java.time.LocalTime;

import com.mk.fitter.api.box.repository.dto.BoxDto;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
@Builder
public class WodRankDto {
	private UserDto userDto;
	private WodDto wodDto;
	private Integer ranking;
	private LocalTime time;
	private Integer count;
}
