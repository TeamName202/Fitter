package com.mk.fitter.api.file.service;

import org.springframework.web.multipart.MultipartFile;

import com.mk.fitter.api.file.repository.dto.ProfileImgDto;

public interface FileService {
	ProfileImgDto saveProfileImg(MultipartFile file) throws Exception;

	void deleteProfileImg(ProfileImgDto profile) throws Exception;

	String createRandomFileName() throws Exception;
}
