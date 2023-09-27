package com.mk.fitter.api.common.oauth.controller;

import java.nio.charset.StandardCharsets;
import java.util.Map;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mk.fitter.api.common.oauth.Role;
import com.mk.fitter.api.common.oauth.VO.UserResponseVO;
import com.mk.fitter.api.common.oauth.service.OAuth2Service;
import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.file.repository.dto.ProfileImgDto;
import com.mk.fitter.api.file.service.FileServiceImpl;
import com.mk.fitter.api.user.repository.dto.UserDto;
import com.mk.fitter.api.user.service.UserService;
import com.mk.fitter.api.user.service.UserServiceImpl;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.models.Response;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/oauth2")
@RequiredArgsConstructor
@Slf4j
@Api(tags = {"카카오 로그인 api"})
public class OAuth2Controller {

	private final OAuth2Service oAuth2Service;
	private final UserServiceImpl userService;
	private final FileServiceImpl fileService;
	private final JwtService jwtService;
	private final String BEARER = "Bearer ";

	@GetMapping(value = "/kakao", produces = "application/json;charset=UTF-8")
	@ApiOperation(value = "카카오 로그인 api", notes = "카카오 로그인 api")
	public ResponseEntity<UserResponseVO> kakaoCallback(
		HttpServletRequest request, HttpServletResponse response,
		@ApiParam(value = "카카오 token", required = true)
		@RequestHeader(name = "Authorization") String kakaoToken) {

		try {
			log.info("로그인 api 진입 :: {}", kakaoToken);

			UserDto userDto = oAuth2Service.kakaoLogin(kakaoToken);

			// access, refresh 토큰 생성
			String accessToken = BEARER + jwtService.createAccessToken(userDto.getId(), userDto.getEmail());
			String refreshToken = BEARER + jwtService.createRefreshToken();

			// refresh token db에 update
			jwtService.updateRefreshToken(userDto.getEmail(), refreshToken);

			// 헤더에 access, refresh 추가
			jwtService.sendAccessAndRefreshToken(response, accessToken, refreshToken);

			// responsebody에 nickname, id 보냄
			UserResponseVO userResponseVO = UserResponseVO.builder()
				.id(userDto.getId())
				.nickname(userDto.getNickname())
				.role(userDto.getRole())
				.build();

			return new ResponseEntity<>(userResponseVO, HttpStatus.OK);
		} catch (Exception e) {
			log.info("소셜 로그인에 실패했습니다. 에러 메시지 : {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@PostMapping(path = "/defaultImg", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	public ResponseEntity<?> saveDefaultProfileImg(@RequestPart(name = "file", required = false) MultipartFile file) {
		try {
			ProfileImgDto profileImgDto = fileService.saveDefaultProfileImg(file);
			return new ResponseEntity<>(profileImgDto, HttpStatus.OK);
		} catch (Exception e) {
			log.error("saveUserInfo :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@ApiOperation(value = "회원가입 시 회원정보 저장", notes = "회원정보 저장")
	@PostMapping(path = "/user-info", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	public ResponseEntity<UserDto> saveUserInfo(
		@ApiParam(value = "프로필사진") @RequestPart(name = "file", required = false) MultipartFile file,
		@ApiParam(value = "회원정보") @RequestPart(name = "user") UserResponseVO user) {
		try {
			UserDto newUser = userService.saveUserInfo(user, file);
			return new ResponseEntity<>(newUser, HttpStatus.OK);
		} catch (Exception e) {
			log.error("saveUserInfo :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@ApiOperation(value = "닉네임 중복체크", notes = "닉네임 중복체크 API")
	@PostMapping("/nickname/duplicate")
	public ResponseEntity<Boolean> checkDupNickname(
		@ApiParam(name = "닉네임, id") @RequestBody Map<String, Object> nicknameMap) {
		try {
			int id = (Integer)nicknameMap.get("id");
			String nickname = (String)nicknameMap.get("nickname");

			return new ResponseEntity<>(userService.checkDupNickname(nickname, id), HttpStatus.OK);
		} catch (Exception e) {
			log.error("checkDupNickname :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@ApiOperation(value = "이메일 중복체크", notes = "이메일 중복체크 API")
	@PostMapping("/email/duplicate")
	public ResponseEntity<Boolean> checkDupEmail(
		@ApiParam(name = "이메일, id") @RequestBody Map<String, Object> emailMap) {
		try {
			int id = (Integer)emailMap.get("id");
			String email = (String)emailMap.get("email");

			return new ResponseEntity<>(userService.checkDupEmail(email, id), HttpStatus.OK);
		} catch (Exception e) {
			log.error("checkDupEmail :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
