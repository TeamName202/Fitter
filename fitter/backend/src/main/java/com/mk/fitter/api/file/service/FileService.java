package com.mk.fitter.api.file.service;

import org.springframework.web.multipart.MultipartFile;

import com.mk.fitter.api.file.repository.dto.ProfileImgDto;

public interface FileService {
	ProfileImgDto saveDefaultProfileImg(MultipartFile file) throws Exception;

	ProfileImgDto saveProfileImg(MultipartFile file) throws Exception;

	byte[] getProfileImg(ProfileImgDto profile) throws Exception;

	byte[] getprofileImg(String fileName) throws Exception;

	ProfileImgDto getProfileImg(int id) throws Exception;

	void deleteProfileImg(ProfileImgDto profile) throws Exception;

	String createRandomFileName() throws Exception;
}
