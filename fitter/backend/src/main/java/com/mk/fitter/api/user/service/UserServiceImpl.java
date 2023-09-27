package com.mk.fitter.api.user.service;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.mk.fitter.api.box.repository.BoxRepository;
import com.mk.fitter.api.box.repository.dto.BoxDto;
import com.mk.fitter.api.common.oauth.Role;
import com.mk.fitter.api.common.oauth.VO.UserResponseVO;
import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.file.repository.dto.ProfileImgDto;
import com.mk.fitter.api.file.service.FileServiceImpl;
import com.mk.fitter.api.user.repository.UserRepository;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

	@Value("${kakao.admin-key}")
	private String ADMIN_KEY;

	@Value("${kakao.unlink-uri}")
	private String KAKAO_UNLINK_PATH;

	private final UserRepository userRepository;
	private final BoxRepository boxRepository;
	private final JwtService jwtService;

	private final FileServiceImpl fileService;

	private final RestTemplate restTemplate = new RestTemplate();

	private final Integer DEFAULT_IMG_ID = 1;

	public UserDto saveUserInfo(UserResponseVO newUserInfo, MultipartFile file) throws Exception {

		UserDto user = userRepository.findById(newUserInfo.getId())
			.orElseThrow(() -> new Exception("saveUserInfo :: 존재하지 않는 사용자입니다."));

		// 프로필사진
		if (file != null) {
			ProfileImgDto profile = fileService.saveProfileImg(file);
			user.setProfileImgDto(profile);
		}

		// 닉네임, 성별, 이메일, 연령대
		user.setNickname(newUserInfo.getNickname());
		user.setGender(newUserInfo.getGender());
		user.setEmail(newUserInfo.getEmail());
		user.setAgeRange(newUserInfo.getAgeRange());

		// box
		if (newUserInfo.getBoxId() != null) {
			BoxDto boxDto = boxRepository.findById(newUserInfo.getBoxId())
				.orElseThrow(() -> new Exception("존재하지 않는 박스입니다."));
			user.setBoxDto(boxDto);
		}
		user.setRole(Role.USER);
		return userRepository.save(user);
	}

	@Override
	public UserDto getUserInfo(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));
		return userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
	}

	@Override
	public ProfileImgDto getProfileImgDto(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("getProfileImg :: 유효하지 않은 access token입니다."));

		UserDto userDto = userRepository.findById(uid)
			.orElseThrow(() -> new Exception("getProfileImg :: 존재하지 않는 사용자입니다."));

		return userDto.getProfileImgDto();
	}

	@Override
	public byte[] getProfileImg(ProfileImgDto profile) throws Exception {
		if(profile == null)
			return null;

		return fileService.getProfileImg(profile);
	}

	@Override
	public String getEmail(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));

		UserDto userDto = userRepository.findById(uid)
			.orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));

		return userDto.getEmail();
	}

	@Override
	public String getNickname(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));

		UserDto userDto = userRepository.findById(uid)
			.orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));

		return userDto.getNickname();
	}

	@Override
	public String getAgeRange(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));

		UserDto userDto = userRepository.findById(uid)
			.orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));

		return userDto.getAgeRange();
	}

	@Override
	public Boolean getGender(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));

		UserDto userDto = userRepository.findById(uid)
			.orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));

		return userDto.getGender();
	}

	@Override
	public Date getBirthday(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));

		UserDto userDto = userRepository.findById(uid)
			.orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));

		return userDto.getBirthday();
	}

	@Override
	public Boolean getIsTrainer(String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));

		UserDto userDto = userRepository.findById(uid)
			.orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));

		return userDto.getIsTrainer();
	}

	@Override
	public UserDto modifyBox(int boxId, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		BoxDto box = boxRepository.findById(boxId)
			.orElseThrow(() -> new Exception("UserService :: 존재하지 않는 box입니다."));
		user.setBoxDto(box);
		userRepository.save(user);
		return user;
	}

	@Override
	public Boolean checkDupEmail(String email, int id) throws Exception {
		UserDto userDto = userRepository.findByIdNotAndEmail(id, email).orElseGet(null);
		return userDto == null;
	}

	@Override
	public Boolean checkDupEmail(String email, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));

		UserDto userDto = userRepository.findByIdNotAndEmail(uid, email).orElseGet(null);
		return userDto == null;
	}

	@Override
	public UserDto modifyEmail(String email, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setEmail(email);
		userRepository.save(user);
		return user;
	}

	// access token으로 닉네임 중복체크
	@Override
	public Boolean checkDupNickname(String nickname, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("checkDupNickname :: 존재하지 않는 사용자입니다."));

		UserDto userDto = userRepository.findByIdNotAndNickname(uid, nickname).orElseGet(() -> null);
		return userDto == null;
	}

	// id로 닉네임 중복체크
	@Override
	public Boolean checkDupNickname(String nickname, int id) throws Exception {
		UserDto userDto = userRepository.findByIdNotAndNickname(id, nickname).orElseGet(() -> null);
		return userDto == null;
	}

	@Override
	public UserDto modifyNickname(String nickname, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setNickname(nickname);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyAgeRange(String ageRange, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setAgeRange(ageRange);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyGender(Boolean gender, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setGender(gender);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyBirthday(Date birthday, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setBirthday(birthday);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyIsTrainer(Boolean isTrainer, String accessToken) throws Exception {
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));
		user.setIsTrainer(isTrainer);
		userRepository.save(user);
		return user;
	}

	@Override
	public UserDto modifyUserProfileImg(MultipartFile file, String accessToken) throws Exception {
		// 사용자 id 가져오기
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));

		// 사용자 dto 받아오기
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));

		// 기존 프로필 사진 서버/db에서 삭제
		ProfileImgDto prevProfile = user.getProfileImgDto();
		if (prevProfile != null && prevProfile.getId() != DEFAULT_IMG_ID) {
			fileService.deleteProfileImg(prevProfile);
		}

		// 새 프로필 사진 서버/db에 저장
		ProfileImgDto newProfile = fileService.saveProfileImg(file);

		// 새 프로필 사진 userDto에 저장
		user.setProfileImgDto(newProfile);
		return userRepository.save(user);
	}

	@Override
	public UserDto deleteUserprofileImg(String accessToken) throws Exception {
		// 사용자 id 가져오기
		Integer uid = jwtService.extractUID(accessToken)
			.orElseThrow(() -> new Exception("UserService :: 유효하지 않은 access token입니다."));

		// 사용자 dto 받아오기
		UserDto user = userRepository.findById(uid).orElseThrow(() -> new Exception("UserService :: 존재하지 않는 사용자입니다."));

		// 사용자 프로필dto
		ProfileImgDto profile = user.getProfileImgDto();

		// 기본 프로필 사진 받아오기
		ProfileImgDto defaultImg = fileService.getProfileImg(1);

		user.setProfileImgDto(defaultImg);

		// 프로필 사진 서버/db에서 삭제
		if (profile != null && profile.getId() != DEFAULT_IMG_ID) {
			fileService.deleteProfileImg(profile);
		}
		return userRepository.save(user);
	}

	// 회원 탈퇴
	@Override
	public void signOut(String accessToken) throws Exception {
		UserDto user = getUserInfo(accessToken);

		user.setProfileImgDto(null);
		userRepository.save(user);

		// 프로필 사진 서버/db에서 삭제
		ProfileImgDto profileImgDto = user.getProfileImgDto();

		if(profileImgDto != null && profileImgDto.getId() != DEFAULT_IMG_ID) {
			fileService.deleteProfileImg(user.getProfileImgDto());
		}

		// 카카오랑 연결 끊기
		String socialId = user.getSocialId();
		unlinkUser(socialId);

		// 사용자 db에서 삭제
		userRepository.deleteById(user.getId());
	}

	// 카카오랑 연결 끊기 구현
	@Override
	public void unlinkUser(String socialId) throws Exception {
		System.out.println(socialId);

		// header 만들기
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/x-www-form-urlencoded");
		headers.add("Authorization", "KakaoAK " + ADMIN_KEY);

		// body 만들기
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("target_id_type", "user_id");
		params.add("target_id", String.valueOf(socialId));

		// header랑 body 합치기
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, headers);

		// post 요청
		ResponseEntity<Map<String, Long>> response = restTemplate.exchange(
			KAKAO_UNLINK_PATH,
			HttpMethod.POST,
			entity,
			new ParameterizedTypeReference<Map<String, Long>>() {
			}
		);

		//System.out.println("UserServiceImpl :: unlinkUser :: " + response.getBody().get("id"));
	}
}
