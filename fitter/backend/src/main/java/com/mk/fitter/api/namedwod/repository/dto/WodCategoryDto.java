package com.mk.fitter.api.namedwod.repository.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity(name = "wod_category")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class WodCategoryDto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String category;
}
