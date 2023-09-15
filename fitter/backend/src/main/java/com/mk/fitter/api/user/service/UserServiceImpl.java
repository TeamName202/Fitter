package com.mk.fitter.api.user.service;

import java.util.Date;

import org.springframework.stereotype.Service;

import com.mk.fitter.api.box.repository.BoxRepository;
import com.mk.fitter.api.box.repository.dto.BoxDto;
import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.user.repository.UserRepository;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	private final UserRepository userRepository;
	private final BoxRepository boxRepository;
	private final JwtService jwtService;

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
		return user;
	}

	@Override
	public UserDto modifyEmail(String email, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setEmail(email);
		return user;
	}

	@Override
	public UserDto modifyNickname(String nickname, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setNickname(nickname);
		return user;
	}

	@Override
	public UserDto modifyAgeRange(String ageRange, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setAgeRange(ageRange);
		return user;
	}

	@Override
	public UserDto modifyGender(Boolean gender, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setGender(gender);
		return user;
	}

	@Override
	public UserDto modifyBirthday(Date birthday, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setBirthday(birthday);
		return user;
	}

	@Override
	public UserDto modifyIsTrainer(Boolean isTrainer, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(()-> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setIsTrainer(isTrainer);
		return user;
	}

	@Override
	public void deleteUser(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken).orElseThrow(()->new Exception("UserService :: 유효하지 않은 access token입니다."));
		userRepository.deleteById(uid);
		return;
	}
}
