package com.mk.fitter.api.user.repository.dto;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import com.mk.fitter.api.box.repository.dto.BoxDto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "user")
@Getter
@Setter
@ToString
@NoArgsConstructor
public class UserDto {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@OneToOne
	@JoinColumn(name = "box_id")
	private BoxDto boxDto;

	@OneToOne
	@JoinColumn(name = "profile_id")
	private ProfileImgDto profileImgDto;

	private String email;

	@Column(name = "refresh_token")
	private String refreshToken;

	private String nickname;

	private int age;

	private boolean gender;

	private Date birthday;

	@Column(name = "is_trainer")
	private boolean isTrainer;

	@Column(name = "regist_date")
	private Date registDate;
}
