package com.mk.fitter.api.common.oauth.VO;

import com.mk.fitter.api.common.oauth.Role;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserResponseVO {
	private int id;
	private String nickname;
	private Role role;
}
