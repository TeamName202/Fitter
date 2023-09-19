package com.mk.fitter.api.common.oauth.userInfo;

import java.util.Map;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class KakaoOAuth2UserInfo extends OAuth2UserInfo {

	private final Map<String, Object> account;

	public KakaoOAuth2UserInfo(Map<String, Object> attributes) {
		super(attributes);
		this.account = (Map<String, Object>)attributes.get("kakao_account");
	}

	@Override
	public String getId() {
		return String.valueOf(attributes.get("id"));
	}

	@Override
	public String getNickname() {
		Map<String, Object> profile = (Map<String, Object>)this.account.get("profile");
		if(this.account == null || profile == null) {
			return "null";
		}

		return (String) profile.get("nickname");
	}

	@Override
	public String getEmail() {
		log.info("KakaoOAuth2UserInfo :: "+(String)account.get("email"));
		if(this.account == null || account.get("email") == null)
			return "null";
		return (String)account.get("email");
	}
	//
	// @Override
	// public Boolean getGender() {
	// 	if(this.account == null || account.get("gender") == null)
	// 		return null;
	// 	return (Boolean)account.get("gender");
	// }
	//
	// @Override
	// public String getAgeRange() {
	// 	if(this.account == null || account.get("age_range") == null)
	// 		return null;
	// 	return (String)account.get("age_range");
	// }

}
