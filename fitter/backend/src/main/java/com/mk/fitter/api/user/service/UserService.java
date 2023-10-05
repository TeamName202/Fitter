package com.mk.fitter.api.user.service;

import java.util.Date;
import java.util.Optional;

import org.springframework.web.multipart.MultipartFile;

import com.mk.fitter.api.common.oauth.VO.UserResponseVO;
import com.mk.fitter.api.file.repository.dto.ProfileImgDto;
import com.mk.fitter.api.user.repository.dto.UserDto;

public interface UserService {
	UserDto saveUserInfo(UserResponseVO user, MultipartFile file) throws Exception;
	UserDto getUserInfo(String accessToken) throws Exception;

	ProfileImgDto getProfileImgDto(String accessToken) throws Exception;
	byte[] getProfileImg(ProfileImgDto profile) throws Exception;
	byte[] getProfileImgByPath(String path) throws Exception;
	String getEmail(String accessToken) throws Exception;
	String getNickname(String accessToken) throws Exception;
	String getAgeRange(String accessToken) throws Exception;
	Boolean getGender(String accessToken) throws Exception;
	Date getBirthday(String accessToken) throws Exception;
	Boolean getIsTrainer(String accessToken) throws Exception;


	UserDto modifyBox(int boxId, String accessToken) throws Exception;

	Boolean checkDupEmail(String email, int id) throws Exception;
	Boolean checkDupEmail(String nickname, String accessToken) throws Exception;
	UserDto modifyEmail(String email, String accessToken) throws Exception;

	Boolean checkDupNickname(String nickname, String accessToken) throws Exception;
	Boolean checkDupNickname(String nickname, int id) throws Exception;
	UserDto modifyNickname(String nickname, String accessToken) throws Exception;

	UserDto modifyAgeRange(String ageRange, String accessToken) throws Exception;
	UserDto modifyGender(Boolean gender, String accessToken) throws Exception;
	UserDto modifyBirthday(Date birthday, String accessToken) throws Exception;
	UserDto modifyIsTrainer(Boolean isTrainer, String accessToken) throws Exception;
	UserDto modifyUserProfileImg(MultipartFile file, String accessToken) throws Exception;

	UserDto deleteUserprofileImg(String accessToken) throws Exception;

	void signOut(String accessToken) throws Exception;
	void unlinkUser(String socialId) throws Exception;

}
