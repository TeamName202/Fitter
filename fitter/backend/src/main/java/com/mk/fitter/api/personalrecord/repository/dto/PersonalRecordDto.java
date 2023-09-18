package com.mk.fitter.api.personalrecord.repository.dto;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity(name = "personal_record")
public class PersonalRecordDto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private UserDto userDto;

	@OneToOne
	@JoinColumn(name = "workout_id")
	private WorkoutDto workoutDto;

	@Column(name = "max_weight")
	private int maxWeight;

	@Column(name = "create_date")
	private LocalDate createDate;
}
