package com.mk.fitter.api.dailyrecord.repository.dto;

import java.time.LocalDate;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.mk.fitter.api.namedwod.repository.dto.WodTypeDto;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "daily_record")
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DailyRecordDto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private UserDto user;

	@ManyToOne
	@JoinColumn(name = "wod_type_id")
	private WodTypeDto wodType;

	private LocalDate date;

	@Column(name = "wod_description")
	private String wodDescription;

	private String memo;

	@OneToMany(mappedBy = "dailyRecordDto")
	@JsonManagedReference
	private List<DailyRecordDetailDto> dailyRecordDetails;

}
