package com.mk.fitter.api.box.repository.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity(name = "box")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BoxDto {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(name = "box_name")
	private String boxName;

	@Column(name = "box_address")
	private String boxAddress;

	private String tel;
}
