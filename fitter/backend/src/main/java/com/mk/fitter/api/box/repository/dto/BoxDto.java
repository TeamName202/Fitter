package com.mk.fitter.api.box.repository.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "box")
@NoArgsConstructor
@Getter
@Setter
@ToString
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
