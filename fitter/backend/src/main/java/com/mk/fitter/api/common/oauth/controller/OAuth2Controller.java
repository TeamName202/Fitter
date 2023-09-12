package com.mk.fitter.api.common.oauth.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.common.oauth.service.CustomOAuthUserService;
import com.mk.fitter.api.user.repository.UserRepository;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/oauth2")
@RequiredArgsConstructor
@Slf4j
public class OAuth2Controller {

	private final CustomOAuthUserService oAuthUserService;

	@PostMapping("/sign-up")
	public ResponseEntity<Boolean> signUp(UserDto user) throws Exception {
		try {
			oAuthUserService.saveUserInfo(user);
			return new ResponseEntity<>(true, HttpStatus.OK);
		} catch (Exception e) {
			log.error("OAuth2Controller :: 회원가입 - 유저 정보 저장 에러");
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
