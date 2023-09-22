package com.mk.fitter.api.user.service;

import java.util.Date;
import java.util.Optional;

import org.springframework.web.multipart.MultipartFile;

import com.mk.fitter.api.user.repository.dto.UserDto;

public interface UserService {
	UserDto saveUserInfo(UserDto user, MultipartFile file) throws Exception;
	UserDto getUserInfo(String accessToken) throws Exception;
	UserDto modifyBox(int boxId, String accessToken) throws Exception;
	UserDto modifyEmail(String email, String accessToken) throws Exception;
	UserDto modifyNickname(String nickname, String accessToken) throws Exception;
	UserDto modifyAgeRange(String ageRange, String accessToken) throws Exception;
	UserDto modifyGender(Boolean gender, String accessToken) throws Exception;
	UserDto modifyBirthday(Date birthday, String accessToken) throws Exception;
	UserDto modifyIsTrainer(Boolean isTrainer, String accessToken) throws Exception;
	UserDto modifyUserProfileImg(MultipartFile file, String accessToken) throws Exception;

	UserDto deleteUserprofileImg(String accessToken) throws Exception;

	void unlinkUser(String accessToken) throws Exception;
	void deleteUser(String accessToken) throws Exception;

}
