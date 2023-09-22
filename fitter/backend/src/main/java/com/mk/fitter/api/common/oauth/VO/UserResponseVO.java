package com.mk.fitter.api.common.oauth.VO;

import com.mk.fitter.api.common.oauth.Role;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserResponseVO {
	private int id;
	private String nickname;
	private Boolean gender;
	private String ageRange;
	private String email;
	private Integer boxId;
	private Role role;
}
