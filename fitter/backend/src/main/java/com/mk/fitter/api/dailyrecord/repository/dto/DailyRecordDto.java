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

import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.mk.fitter.api.namedwod.repository.dto.WodTypeDto;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity(name = "daily_record")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@DynamicUpdate
@DynamicInsert
public class DailyRecordDto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@ManyToOne
	@JoinColumn(name = "user_id")
	private UserDto userDto;

	@ManyToOne
	@JoinColumn(name = "wod_type_id")
	private WodTypeDto wodTypeDto;

	private LocalDate date;

	@Column(name = "wod_description")
	private String wodDescription;

	private String memo;

	@OneToMany(mappedBy = "dailyRecordDto")
	@JsonManagedReference
	private List<DailyRecordDetailDto> dailyRecordDetails;

}
