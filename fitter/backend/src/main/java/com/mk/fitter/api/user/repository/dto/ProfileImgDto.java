package com.mk.fitter.api.user.repository.dto;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "profile_img")
@NoArgsConstructor
@Getter
@Setter
@ToString
public class ProfileImgDto {
	@Id
	private int id;

	@Column(name = "file_path")
	private String filePath;
}
