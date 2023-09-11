package com.mk.fitter.api.common.oauth.VO;

import java.util.Map;
import java.util.UUID;

import com.mk.fitter.api.common.oauth.Role;
import com.mk.fitter.api.common.oauth.SocialType;
import com.mk.fitter.api.common.oauth.userInfo.KakaoOAuth2UserInfo;
import com.mk.fitter.api.common.oauth.userInfo.OAuth2UserInfo;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.Builder;
import lombok.Getter;

@Getter
public class OAuthAttributes {

	// OAuth2 로그인 진행 시 키가 되는 필드 값
	private String nameAttributeKey;
	// 소셜 타입 별 로그인 유저 정보(닉네임, 이메일, 성별, 연령대)
	private OAuth2UserInfo oAuth2UserInfo;

	@Builder
	public OAuthAttributes(String nameAttributeKey, OAuth2UserInfo oAuth2UserInfo) {
		this.nameAttributeKey = nameAttributeKey;
		this.oAuth2UserInfo = oAuth2UserInfo;
	}

	/**
	 * OAuthProvider에 맞는 메소드 호출하여 OAuthAttributes 객체 반환
	 * @param userNameAttributeName : OAuth2 로그인 시 키(PK)가 되는 값
	 * @param attributes: OAuth 서비스의 유저 정보들
	 * 소셜별 of 메소드(ofGoogle, ofKaKao, ofNaver)들은 각각 소셜 로그인 API에서 제공하는
	 * 회원의 식별값(id), attributes, nameAttributeKey를 저장 후 build
	 */
	public static OAuthAttributes of(SocialType provider,
		String userNameAttributeName, Map<String, Object> attributes) {
		if(provider == SocialType.KAKAO){
			return ofKakao(userNameAttributeName, attributes);
		}
		return null;
	}

	private static OAuthAttributes ofKakao(String userNameAttributeName, Map<String, Object>attributes) {
		return OAuthAttributes.builder()
			.nameAttributeKey(userNameAttributeName)
			.oAuth2UserInfo(new KakaoOAuth2UserInfo(attributes))
			.build();
	}

	/**
	 * of메소드로 OAuthAttributes 객체가 생성되어, 유저 정보들이 담긴 OAuth2UserInfo가 소셜 타입별로 주입된 상태
	 * OAuth2UserInfo에서 socialId(식별값), nickname, imageUrl을 가져와서 build
	 * email에는 UUID로 중복 없는 랜덤 값 생성
	 * role은 GUEST로 설정
	 */
	public UserDto toEntity(SocialType socialType, OAuth2UserInfo oAuth2UserInfo) {
		return UserDto.builder()
			.socialType(socialType)
			.socialId(oAuth2UserInfo.getId())
			.email(UUID.randomUUID() + "@socialUser.com")
			.nickname(oAuth2UserInfo.getNickname())
			.role(Role.GUEST)
			.build();
	}

}
