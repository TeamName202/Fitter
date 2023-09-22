package com.mk.fitter.api.common.oauth.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

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

	@GetMapping("/kakao")
	@ApiOperation(value = "카카오 로그인 api", notes = "카카오 로그인 api")
	public ResponseEntity<UserResponseVO> kakaoCallback(
		HttpServletRequest request, HttpServletResponse response,
		@ApiParam(value = "카카오 token", required = true)
		@RequestHeader(name = "Authorization") String kakaoToken) {

		try {
			log.info("로그인 api 진입");
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

	@ApiOperation(value = "회원가입 시 회원정보 저장", notes = "회원정보 저장")
	@PostMapping(path = "/user-info", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	public ResponseEntity<UserDto> saveUserInfo(@ApiParam(value = "프로필사진") @RequestPart(name = "file") MultipartFile file, @ApiParam(value = "회원정보") @RequestBody UserDto user) {
		try {
			UserDto newUser = userService.saveUserInfo(user, file);
			return new ResponseEntity<>(newUser, HttpStatus.OK);
		} catch (Exception e) {
			log.error("saveUserInfo :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
