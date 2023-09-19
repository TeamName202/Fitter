package com.mk.fitter.api.user.service;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.mk.fitter.api.box.repository.BoxRepository;
import com.mk.fitter.api.box.repository.dto.BoxDto;
import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.user.repository.UserRepository;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	@Value("${kakao.admin-key}")
	private String ADMIN_KEY;

	@Value("${kakao.unlink-uri}")
	private String KAKAO_UNLINK_PATH;

	private final UserRepository userRepository;
	private final BoxRepository boxRepository;
	private final JwtService jwtService;

	private final RestTemplate restTemplate = new RestTemplate();

	public UserDto saveUserInfo(UserDto user) throws Exception {
		return userRepository.save(user);
	}

	@Override
	public UserDto getUserInfo(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()-> new Exception("UserService :: 유효하지 않은 access token입니다."));
		return userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
	}

	@Override
	public UserDto modifyBox(int boxId, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()-> new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		BoxDto box = boxRepository.findById(boxId)
			.orElseThrow(() -> new Exception("UserService :: 존재하지 않는 box입니다."));
		user.setBoxDto(box);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyEmail(String email, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setEmail(email);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyNickname(String nickname, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setNickname(nickname);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyAgeRange(String ageRange, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setAgeRange(ageRange);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyGender(Boolean gender, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setGender(gender);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyBirthday(Date birthday, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setBirthday(birthday);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyIsTrainer(Boolean isTrainer, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setIsTrainer(isTrainer);
		userRepository.save(user);
		return user;
	}

	// 카카오랑 연결 끊기 구현
	@Override
	public void unlinkUser(String accessToken) throws Exception {
		UserDto user = getUserInfo(accessToken);
		String socialId = user.getSocialId();
		System.out.println(socialId);

		// header 만들기
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/x-www-form-urlencoded");
		headers.add("Authorization", "KakaoAK " + ADMIN_KEY);

		// body 만들기
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("target_id_type", "user_id");
		params.add("target_id", String.valueOf(socialId));

		// header랑 body 합치기
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, headers);

		// post 요청
		ResponseEntity<Map<String, Long>> response = restTemplate.exchange(
			KAKAO_UNLINK_PATH,
			HttpMethod.POST,
			entity,
			new ParameterizedTypeReference<Map<String, Long>>() {}
		);

		//System.out.println("UserServiceImpl :: unlinkUser :: " + response.getBody().get("id"));
	}

	@Override
	public void deleteUser(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		userRepository.deleteById(uid);
	}
}
