package com.mk.fitter.api.personalrecord.repository.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PersonalRecordCreateRequest {
	private String workoutName;

	private int maxWeight;
}