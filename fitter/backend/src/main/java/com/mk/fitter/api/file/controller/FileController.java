package com.mk.fitter.api.file.controller;

import java.io.File;
import java.nio.file.Files;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.file.service.FileServiceImpl;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@RequestMapping("/file")
@Slf4j
@Api(tags = {"파일 API"})
public class FileController {

	private FileServiceImpl fileService;

	@Value("${spring.servlet.multipart.location}")
	private String FILE_PATH;

	@Value("${file.folder.profile}")
	private String PROFILE_FOLDER;

	@GetMapping(path = "/profile-img/{filename}")
	@ApiOperation(value = "path로 프로필 사진 조회", notes = "path로 프로필 사진을 조회하는 API")
	public ResponseEntity<byte[]> getProfileImgByFileName(@PathVariable(name = "filename") String fileName) {
		try {
			String path = FILE_PATH + PROFILE_FOLDER + fileName;
			// 프로필 사진 경로를 사용해서 File 객체 만듦
			File file = new File(path);

			// 파일 확장자에 따라 파일 헤더 세팅
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-type", Files.probeContentType(file.toPath()));

			return new ResponseEntity<>(fileService.getProfileImg(path), headers, HttpStatus.OK);

		} catch (Exception e) {
			log.error("getProfileImgByPath :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
