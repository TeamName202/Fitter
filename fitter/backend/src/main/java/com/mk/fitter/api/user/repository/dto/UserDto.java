package com.mk.fitter.api.user.repository.dto;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import org.hibernate.annotations.DynamicInsert;

import com.mk.fitter.api.box.repository.dto.BoxDto;
import com.mk.fitter.api.common.oauth.Role;
import com.mk.fitter.api.common.oauth.SocialType;
import com.mk.fitter.api.file.repository.dto.ProfileImgDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity(name = "user")
@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
@DynamicInsert
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

	@Column(name = "age_range")
	private String ageRange;

	private Boolean gender;

	private Date birthday;

	@Column(name = "is_trainer")
	private Boolean isTrainer;

	@Column(name = "regist_date")
	private Date registDate;

	@Enumerated(EnumType.STRING)
	private Role role;

	@Column(name = "social_id")
	private String socialId;

	@Enumerated(EnumType.STRING)
	@Column(name = "social_type")
	private SocialType socialType;

	public void authorizeUser() {
		this.role = Role.USER;
	}

	public void updateRefreshToken(String updateRefreshToken) {
		this.refreshToken = updateRefreshToken;
	}
}
