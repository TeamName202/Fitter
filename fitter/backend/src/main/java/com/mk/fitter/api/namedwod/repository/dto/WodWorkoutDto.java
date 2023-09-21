package com.mk.fitter.api.namedwod.repository.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.mk.fitter.api.personalrecord.repository.dto.WorkoutDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity(name = "wod_workout")
@NoArgsConstructor
@AllArgsConstructor
public class WodWorkoutDto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "wod_id")
	@JsonBackReference
	private WodDto wodDto;

	@ManyToOne
	@JoinColumn(name = "workout_id")
	private WorkoutDto workoutDto;

	private int weight;

	private int count;

	private double distance;

}
