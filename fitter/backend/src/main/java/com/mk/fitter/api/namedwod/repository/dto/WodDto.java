package com.mk.fitter.api.namedwod.repository.dto;

import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity(name = "wod")
@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
public class WodDto {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "wod_type_id")
	private WodTypeDto wodType;

	@ManyToOne
	@JoinColumn(name = "wod_category_id")
	private WodCategoryDto wodCategoryDto;

	private String name;

	@Column(name = "is_named")
	private boolean isNamed;

	private String rep;

	private int round;

	@Column(name = "time_cap")
	private LocalTime timeCap;
}
