package com.mk.fitter.api.file.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.Optional;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mk.fitter.api.file.repository.ProfileImgRepository;
import com.mk.fitter.api.file.repository.dto.ProfileImgDto;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FileServiceImpl implements FileService {
	@Value("${spring.servlet.multipart.location}")
	private String FILE_PATH;

	@Value("${file.folder.profile}")
	private String PROFILE_FOLDER;

	private final ProfileImgRepository profileImgRepository;

	@Override
	public ProfileImgDto saveDefaultProfileImg(MultipartFile file) throws Exception {
		if(file.isEmpty())
			return null;

		// 파일 정보
		String origFileName = file.getOriginalFilename();
		String uuid = createRandomFileName();
		String extension = origFileName.substring(origFileName.lastIndexOf("."));
		String savedName = uuid+extension;
		String savedPath = FILE_PATH+PROFILE_FOLDER+savedName;

		// dto build
		ProfileImgDto profile = ProfileImgDto.builder()
			.id(1)
			.fileName(savedName)
			.filePath(savedPath)
			.origName(origFileName)
			.build();

		// 서버에 저장
		file.transferTo(new File(savedPath));
		// db에 저장
		return profileImgRepository.save(profile);
	}

	@Override
	public ProfileImgDto saveProfileImg(MultipartFile file) throws Exception {
		if(file.isEmpty())
			return null;

		// 파일 정보
		String origFileName = file.getOriginalFilename();
		String uuid = createRandomFileName();
		String extension = origFileName.substring(origFileName.lastIndexOf("."));
		String savedName = uuid+extension;
		String savedPath = FILE_PATH+PROFILE_FOLDER+savedName;

		// dto build
		ProfileImgDto profile = ProfileImgDto.builder()
			.fileName(savedName)
			.filePath(savedPath)
			.origName(origFileName)
			.build();

		// 서버에 저장
		file.transferTo(new File(savedPath));
		// db에 저장
		return profileImgRepository.save(profile);
	}

	@Override
	public byte[] getProfileImg(ProfileImgDto profile) throws Exception {
		InputStream inputStream = new FileInputStream(profile.getFilePath());
		byte[] imageByteArray = IOUtils.toByteArray(inputStream);
		inputStream.close();
		return imageByteArray;
	}

	@Override
	public ProfileImgDto getProfileImg(int id) throws Exception {
		 return profileImgRepository.findById(id).orElseThrow(() -> new Exception("getProfileImg :: 존재하지 않는 이미지입니다"));
	}

	@Override
	public void deleteProfileImg(ProfileImgDto profile) throws Exception {
		// 서버에 저장된 이미지 파일 삭제
		String prevFilePath = profile.getFilePath();
		File prevProfile = new File(prevFilePath);
		if(prevProfile.delete()) {
			log.info("EC2 :: 프로필 사진 삭제 성공!");
		} else {
			log.error("EC2 :: 프로필 사진 삭제 실패");
		}

		// db에 저장된 이미지 삭제
		profileImgRepository.deleteById(profile.getId());
	}

	@Override
	public String createRandomFileName() throws Exception {
		return UUID.randomUUID().toString();
	}
}
