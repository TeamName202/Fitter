package com.mk.fitter.api.user.controller;

import java.io.File;
import java.nio.file.Files;
import java.util.Date;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.mk.fitter.api.file.repository.dto.ProfileImgDto;
import com.mk.fitter.api.user.repository.dto.UserDto;
import com.mk.fitter.api.user.service.UserServiceImpl;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
@Slf4j
@Api(tags = {"유저 API"})
public class UserController {

	private final UserServiceImpl userService;

	@GetMapping("/user-info")
	@ApiOperation(value = "유저 정보", notes = "유저 정보를 조회하는 API")
	public ResponseEntity<UserDto> getUserInfo(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.getUserInfo(accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("getUserInfo :: {} ", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping(path = "/profile-img")
	@ApiOperation(value = "유저의 프로필 사진 조회", notes = "유저의 프로필 사진을 조회하는 API")
	public ResponseEntity<byte[]> getProfileImg(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			// 프로필 사진 dto
			ProfileImgDto profileImgDto = userService.getProfileImgDto(accessToken);

			// 프로필 사진 경로를 사용해서 File 객체 만듦
			File file = new File(profileImgDto.getFilePath());

			// 파일 확장자에 따라 파일 헤더 세팅
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-type", Files.probeContentType(file.toPath()));

			return new ResponseEntity<>(userService.getProfileImg(profileImgDto), headers, HttpStatus.OK);
		} catch (Exception e) {
			log.error("getProfileImg :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping(path = "/profile-img/{path}")
	@ApiOperation(value = "path로 프로필 사진 조회", notes = "path로 프로필 사진을 조회하는 API")
	public ResponseEntity<byte[]> getProfileImgByPath(@PathVariable(name = "path") String path, @RequestHeader(name = "Authorization") String accessToken) {
		try {
			// 프로필 사진 경로를 사용해서 File 객체 만듦
			File file = new File(path);

			// 파일 확장자에 따라 파일 헤더 세팅
			HttpHeaders headers = new HttpHeaders();
			headers.add("Content-type", Files.probeContentType(file.toPath()));

			return new ResponseEntity<>(userService.getProfileImgByPath(path), headers, HttpStatus.OK);

		} catch (Exception e) {
			log.error("getProfileImgByPath :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/email")
	@ApiOperation(value = "유저의 이메일 조회", notes = "유저의 이메일을 조회하는 API")
	public ResponseEntity<String> getEmail(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.getEmail(accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("getEmail :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/nickname")
	@ApiOperation(value = "유저의 닉네임 조회", notes = "유저의 닉네임을 조회하는 API")
	public ResponseEntity<String> getNickname(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.getNickname(accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("getNickname :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/age-range")
	@ApiOperation(value = "유저의 연령대 조회", notes = "유저의 연령대를 조회하는 API")
	public ResponseEntity<String> getAgeRange(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.getAgeRange(accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("getAgeRange :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/gender")
	@ApiOperation(value = "유저의 성별 조회", notes = "유저의 성별을 조회하는 API, true : 남성, false : 여성")
	public ResponseEntity<Boolean> getGender(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.getGender(accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("getGender :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/birthday")
	@ApiOperation(value = "유저의 생일 조회", notes = "유저의 생일을 조회하는 API")
	public ResponseEntity<Date> getBirthday(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.getBirthday(accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("getBirthday :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/is-trainer")
	@ApiOperation(value = "유저의 트레이너 여부", notes = "유저가 트레이너인지 조회하는 API")
	public ResponseEntity<Boolean> getIsTrainer(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.getIsTrainer(accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("getIsTrainder :: {}", e.getMessage());
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

	@PostMapping("/email/duplicate")
	@ApiOperation(value = "유저 이메일 중복체크", notes = "유저 이메일 중복체크 API")
	public ResponseEntity<Boolean> checkDupEmail(@ApiParam(value = "유저 이메일") @RequestBody Map<String, String> emailMap,
		@ApiParam(value = "access token") @RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.checkDupEmail(emailMap.get("email"), accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("checkDupEmail :: {}", e.getMessage());
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
			log.error("modifyEmail :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/nickname/duplicate")
	@ApiOperation(value = "유저 닉네임 중복 체크", notes = "유저 닉네임 중복 체크하는 API")
	public ResponseEntity<Boolean> checkDupNickname(
		@ApiParam(value = "유저 닉네임") @RequestBody Map<String, String> nicknameMap,
		@ApiParam(value = "access token") @RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.checkDupNickname(nicknameMap.get("nickname"), accessToken),
				HttpStatus.OK);
		} catch (Exception e) {
			log.error("checkDupNickname :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/nickname")
	@ApiOperation(value = "유저 닉네임 수정", notes = "유저의 닉네임을 수정하는 API")
	public ResponseEntity<UserDto> modifyNickname(@RequestBody Map<String, String> nicknameMap,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(userService.modifyNickname(nicknameMap.get("nickname"), accessToken),
				HttpStatus.OK);
		} catch (Exception e) {
			log.error("modifyNickname :: {}", e.getMessage());
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
	@ApiOperation(value = "유저 성별 수정", notes = "유저의 성별을 수정하는 API, 남성:true 여성:false")
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

	@PostMapping(path = "/profile", consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
	@ApiOperation(value = "프로필 사진 수정", notes = "프로필 사진 수정하는 API")
	public ResponseEntity<UserDto> saveUserProfileImg(@RequestPart("file") MultipartFile file,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			log.info("프로필 수정 컨트롤러 시작!");
			log.info("파일 : {}", file);
			UserDto userDto = userService.modifyUserProfileImg(file, accessToken);
			return new ResponseEntity<>(userDto, HttpStatus.OK);
		} catch (Exception e) {
			log.error("userProfileImg :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@DeleteMapping("/profile")
	@ApiOperation(value = "프로필 사진 삭제", notes = "프로필 사진 삭제하는 API")
	public ResponseEntity<UserDto> deleteUserProfileImg(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			UserDto userDto = userService.deleteUserprofileImg(accessToken);
			return new ResponseEntity<>(userDto, HttpStatus.OK);
		} catch (Exception e) {
			log.error("deleteUserProfileImg :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@DeleteMapping
	@ApiOperation(value = "유저 탈퇴", notes = "회원탈퇴를 하는 API")
	public ResponseEntity<String> deleteUser(@RequestHeader(name = "Authorization") String accessToken) {
		try {
			userService.signOut(accessToken);
			return new ResponseEntity<>("UserController :: 사용자 삭제 성공", HttpStatus.OK);
		} catch (Exception e) {
			log.error("deleteUser :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
