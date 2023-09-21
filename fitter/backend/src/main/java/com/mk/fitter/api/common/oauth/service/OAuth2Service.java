package com.mk.fitter.api.common.oauth.service;

import java.util.Map;
import java.util.Optional;

import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mk.fitter.api.common.oauth.SocialType;
import com.mk.fitter.api.common.oauth.VO.OAuthAttributes;
import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.user.repository.UserRepository;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class OAuth2Service {
	@Value("${kakao.user-info-uri}")
	private String USERINFO_URI;

	@Value("${spring.security.oauth2.client.registration.kakao.client-id}")
	private String RESTAPI_KEY;

	private SocialType socialType = SocialType.KAKAO;

	private final UserRepository userRepository;
	private final JwtService jwtService;

	public UserDto kakaoLogin(String accessToken) throws Exception {
		Map<String, Object> userInfo = getUserInfo(accessToken);
		String userNameAttributeName = "kakao";
		OAuthAttributes extractAttributes = OAuthAttributes.of(socialType, userNameAttributeName, userInfo);
		return getUser(extractAttributes, socialType).orElseGet(()->saveUser(extractAttributes, socialType));
	}

	public Map<String, Object> getUserInfo(String accessToken) throws Exception {

		UserDto user = new UserDto();
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/x-www-form-urlencoded");
		headers.add("Authorization", "Bearer " + accessToken);

		HttpEntity<String> entity = new HttpEntity<>(headers);

		ResponseEntity<String> response = restTemplate.exchange(
			USERINFO_URI,
			HttpMethod.GET,
			entity,
			String.class
		);

		String responseBody = response.getBody();
		ObjectMapper objectMapper = new ObjectMapper();
		String userNameAttributeName = "id";

		Map<String, Object> attributes = objectMapper.readValue(responseBody, Map.class);

		return attributes;
	}

	private Optional<UserDto> getUser(OAuthAttributes attributes, SocialType socialType) {
		Optional<UserDto> findUser = userRepository.findBySocialTypeAndSocialId(socialType, attributes.getOAuth2UserInfo().getId());
		log.info("getUser attribute :: "+attributes.getOAuth2UserInfo());
		log.info("getUser attribute id :: "+attributes.getOAuth2UserInfo().getId());
		return findUser;

	}

	private UserDto saveUser(OAuthAttributes attributes, SocialType socialType) {
		UserDto createdUser = attributes.toEntity(socialType, attributes.getOAuth2UserInfo());
		return userRepository.save(createdUser);
	}

}

