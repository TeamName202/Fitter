package com.mk.fitter.api.namedwod.repository.dto;

import java.time.LocalDate;
import java.time.LocalTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity(name = "wod_record")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@DynamicInsert
@DynamicUpdate
public class WodRecordDto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@JoinColumn(name = "wod_id")
	@ManyToOne
	private WodDto wod;

	@JoinColumn(name = "user_id")
	@ManyToOne
	private UserDto user;

	private LocalTime time;

	private int count;

	@Column(name = "create_date")
	private LocalDate createDate;
}
