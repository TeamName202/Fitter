package com.mk.fitter.api.common.oauth.userInfo;

import java.util.Map;

public abstract class OAuth2UserInfo {
	protected Map<String, Object> attributes;

	public OAuth2UserInfo(Map<String, Object> attributes){
		this.attributes = attributes;
	}

	// 소셜 식별 값 : 구글 - "sub", 카카오 - "id", 네이버 - "id"
	public abstract String getId();

	// 닉네임
	public abstract String getNickname();

	// 이메일
	public abstract String getEmail();

	// 성별
	public abstract String getGender();

	// 연령대
	public abstract String getAgeRange();

}
