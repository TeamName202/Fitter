package com.mk.fitter.api.common.oauth.VO;

import java.util.Map;

public class OAuth2UserInfo {
	// 닉네임, 이메일, 성별, 연령대
	protected Map<String, Object> attributes;
	protected Map<String, Object> account;
	public OAuth2UserInfo(Map<String, Object> attributes) {
		this.attributes = attributes;
		this.account = (Map<String, Object>)attributes.get("kakao_account");
	}

	public String getId() {
		return String.valueOf(attributes.get("id"));
	}

	public String getNickname() {
		Map<String, Object> profile = (Map<String, Object>)account.get("profile");

		if(account == null || profile == null)
			return null;

		return (String)profile.get("nickname");
	}

	public String getEmail() {
		String email = (String)account.get("email");
		if(account == null || email == null ) return null;
		return email;
	}

	public String getGender() {
		String gender = (String)account.get("gender");
		if(account == null || gender == null) return null;
		return gender;
	}

	public String getAgeRange() {
		return null;
	}
}
