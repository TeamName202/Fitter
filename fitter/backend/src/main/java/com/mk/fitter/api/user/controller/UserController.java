package com.mk.fitter.api.user.controller;

import java.util.Date;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.user.repository.dto.UserDto;
import com.mk.fitter.api.user.service.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
@Slf4j
public class UserController {

	private final UserService userService;

	@GetMapping("/userInfo")
	public ResponseEntity<UserDto> getUserInfo(@RequestHeader String accessToken) {
		try {
			return new ResponseEntity<>(userService.getUserInfo(accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/box/{boxId}")
	public ResponseEntity<UserDto> modifyBox(@PathVariable(name = "boxId") Integer boxId, @RequestHeader String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyBox(boxId, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/email/{email}")
	public ResponseEntity<UserDto> modifyEmail(@PathVariable(name = "email") String email, @RequestHeader String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyEmail(email, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/nickname/{nickname}")
	public ResponseEntity<UserDto> modifyNickname(@PathVariable(name = "nickname") String nickname, @RequestHeader String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyNickname(nickname, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/age-range/{ageRange}")
	public ResponseEntity<UserDto> modifyAgeRange(@PathVariable(name = "ageRange") String ageRange, @RequestHeader String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyAgeRange(ageRange, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/gender/{gender}")
	public ResponseEntity<UserDto> modifyGender(@PathVariable(name = "gender") Boolean gender, @RequestHeader String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyGender(gender, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/birthday/{birthday}")
	public ResponseEntity<UserDto> modifyBirthday(@PathVariable(name = "birthday")Date birthday, @RequestHeader String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyBirthday(birthday, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/is-trainder/{isTrainder}")
	public ResponseEntity<UserDto> modifyIsTrainer(@PathVariable(name = "isTrainer")Boolean isTrainer, @RequestHeader String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyIsTrainer(isTrainer, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// TODO : 카카오랑 연결 끊기 구현하기
	@DeleteMapping
	public ResponseEntity<String> deleteUser(@RequestHeader String accessToken) {
		try {
			userService.deleteUser(accessToken);
			return new ResponseEntity<>("UserController :: 사용자 삭제 성공", HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
