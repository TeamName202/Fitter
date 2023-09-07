package com.mk.fitter.api.user.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.user.service.LoginServiceImpl;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/login")
public class UserController {

	private final LoginServiceImpl loginService;

	@GetMapping("/oauth2/kakao")
	public void login(@RequestParam(name = "code") String code) {

	}
}
