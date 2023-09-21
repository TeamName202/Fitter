package com.mk.fitter.api.file.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.mk.fitter.api.file.repository.ProfileImgRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FileServiceImpl {
	@Value("${spring.servlet.multipart.location}")
	private String FILE_PATH;

	@Value("${file.folder.profile}")
	private String PROFILE_FOLDER;

	private final ProfileImgRepository profileImgRepository;




}
