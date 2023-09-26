package com.mk.fitter.api.namedwod.repository.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WodRecordCreateRequest {

	private int wodId;
	private LocalTime time;
	private int count;
	private LocalDate createDate;
}
