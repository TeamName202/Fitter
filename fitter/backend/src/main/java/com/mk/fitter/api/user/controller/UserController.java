package com.mk.fitter.api.user.controller;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.mk.fitter.api.user.repository.dto.UserDto;
import com.mk.fitter.api.user.service.UserService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
@Slf4j
@Api(tags = {"유저 API"})
public class UserController {

	private final UserService userService;

	@GetMapping("/userInfo")
	@ApiOperation(value = "유저 정보", notes = "유저 정보를 조회하는 API")
	public ResponseEntity<UserDto> getUserInfo(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.getUserInfo(accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("getUserInfo :: {} ", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/box/{boxId}")
	@ApiOperation(value = "유저 박스 수정", notes = "유저의 박스를 수정하는 API")
	public ResponseEntity<UserDto> modifyBox(@PathVariable(name = "boxId") Integer boxId,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyBox(boxId, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("modifyBox :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/email")
	@ApiOperation(value = "유저 이메일 수정", notes = "유저의 이메일을 수정하는 API")
	public ResponseEntity<UserDto> modifyEmail(@RequestBody Map<String, String> emailMap,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyEmail(emailMap.get("email"), accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("modifyEmail :: {}",e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/nickname")
	@ApiOperation(value = "유저 닉네임 수정", notes = "유저의 닉네임을 수정하는 API")
	public ResponseEntity<UserDto> modifyNickname(@RequestBody Map<String, String> nicknameMap,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyNickname(nicknameMap.get("nickname"), accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("modifyNickname :: {}",e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/age-range/{ageRange}")
	@ApiOperation(value = "유저 연령대 수정", notes = "유저의 연령대를 수정하는 API")
	public ResponseEntity<UserDto> modifyAgeRange(@PathVariable(name = "ageRange") String ageRange,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyAgeRange(ageRange, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("modifyAgeRange :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/gender/{gender}")
	@ApiOperation(value = "유저 성별 수정", notes = "유저의 성별을 수정하는 API")
	public ResponseEntity<UserDto> modifyGender(@PathVariable(name = "gender") Boolean gender,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyGender(gender, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("modifyGender :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/birthday/{birthday}")
	@ApiOperation(value = "유저 생일 수정", notes = "유저의 생일을 수정하는 API")
	public ResponseEntity<UserDto> modifyBirthday(@PathVariable(name = "birthday") Date birthday,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyBirthday(birthday, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("modifyBirthday :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/is-trainder/{isTrainder}")
	@ApiOperation(value = "유저 트레이너 여부 수정", notes = "유저가 트레이너인지를 수정하는 API")
	public ResponseEntity<UserDto> modifyIsTrainer(@PathVariable(name = "isTrainer") Boolean isTrainer,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyIsTrainer(isTrainer, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("modifyIsTrainer :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	// TODO : 카카오랑 연결 끊기 구현하기
	@DeleteMapping
	@ApiOperation(value = "유저 탈퇴", notes = "회원탈퇴를 하는 API")
	public ResponseEntity<String> deleteUser(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			// 카카오랑 연결 끊기
			userService.unlinkUser(accessToken);

			// db에서 지우기
			userService.deleteUser(accessToken);
			return new ResponseEntity<>("UserController :: 사용자 삭제 성공", HttpStatus.OK);
		} catch (Exception e) {
			log.error("deleteUser :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
