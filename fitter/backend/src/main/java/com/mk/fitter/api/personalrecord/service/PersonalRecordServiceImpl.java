package com.mk.fitter.api.personalrecord.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.mk.fitter.api.personalrecord.repository.PersonalRecordRepository;
import com.mk.fitter.api.personalrecord.repository.WorkoutRepository;
import com.mk.fitter.api.personalrecord.repository.WorkoutTypeRepository;
import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordCreateRequest;
import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordDto;
import com.mk.fitter.api.personalrecord.repository.dto.WorkoutDto;
import com.mk.fitter.api.personalrecord.repository.dto.WorkoutTypeDto;
import com.mk.fitter.api.user.repository.UserRepository;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PersonalRecordServiceImpl implements PersonalRecordService {

	private final PersonalRecordRepository personalRecordRepository;
	private final UserRepository userRepository;
	private final WorkoutRepository workoutRepository;
	private final WorkoutTypeRepository workoutTypeRepository;

	@Override
	public List<PersonalRecordDto> getRecordList(Integer userId) {

		return personalRecordRepository.findByUserDto_Id(userId);
	}

	@Override
	public PersonalRecordDto getRecord(int personalRecordId) throws Exception {
		Optional<PersonalRecordDto> byId = personalRecordRepository.findById(personalRecordId);
		if (byId.isEmpty()) {
			throw new Exception("기록이 존재하지 않습니다.");
		}
		return byId.get();
	}

	@Override
	public boolean creatRecord(Integer userId, PersonalRecordCreateRequest requestBody) throws Exception {
		Optional<UserDto> byId = userRepository.findById(userId);
		if (byId.isEmpty()) {
			throw new Exception("유저가 존재하지 않습니다.");
		}
		String workoutName = requestBody.getWorkoutName();
		Optional<WorkoutDto> findWorkout = workoutRepository.findByName(workoutName);
		if (findWorkout.isEmpty()) {
			throw new Exception("운동이 존재하지 않습니다.");
		}
		PersonalRecordDto record = PersonalRecordDto.builder()
			.userDto(byId.get())
			.workoutDto(findWorkout.get())
			.maxWeight(requestBody.getMaxWeight())
			.build();
		PersonalRecordDto save = personalRecordRepository.save(record);
		return true;
	}

	@Override
	public boolean modifyRecord(Integer userId, HashMap<String, Integer> requestBody, int personalRecordId) throws
		Exception {
		Optional<UserDto> findUser = userRepository.findById(userId);
		if (findUser.isEmpty()) {
			throw new Exception("존재하지 않는 유저입니다.");
		}
		Optional<PersonalRecordDto> findRecord = personalRecordRepository.findById(personalRecordId);
		if (findRecord.isEmpty()) {
			throw new Exception("존재하지 않는 기록입니다.");
		}
		if (findRecord.get().getUserDto().getId() != userId) {
			throw new Exception("본인이 작성한 기록이 아닙니다.");
		}
		PersonalRecordDto personalRecordDto = findRecord.get();
		personalRecordDto.setMaxWeight(requestBody.get("maxWeight"));
		personalRecordRepository.save(personalRecordDto);
		return true;
	}

	@Override
	public Boolean deleteRecord(int personalRecordId, Integer userId) throws Exception {
		Optional<UserDto> findUser = userRepository.findById(userId);
		if (findUser.isEmpty()) {
			throw new Exception("존재하지 않는 유저입니다.");
		}
		Optional<PersonalRecordDto> findRecord = personalRecordRepository.findById(personalRecordId);
		if (findRecord.isEmpty()) {
			throw new Exception("존재하지 않는 기록입니다.");
		}
		if (findRecord.get().getUserDto().getId() != userId) {
			throw new Exception("본인이 작성한 기록이 아닙니다.");
		}

		return personalRecordRepository.deleteById(personalRecordId);
	}

	@Override
	public List<WorkoutTypeDto> getWorkoutCategory() {
		return workoutTypeRepository.findAll();
	}

	@Override
	public List<WorkoutDto> getWorkoutList() {
		return workoutRepository.findAll();
	}

	@Override
	public List<Map<String, String>> getRankList(Integer userId) {
		return personalRecordRepository.findRankByUserDto_Id(userId);
	}

	@Override
	public List<PersonalRecordDto> getRecordListByWorkoutName(Integer userId, String workoutName) throws Exception {
		Optional<UserDto> byId = userRepository.findById(userId);
		if (byId.isEmpty()) {
			throw new Exception("존재하지 않는 유저입니다.");
		}
		Optional<WorkoutDto> byName = workoutRepository.findByName(workoutName);
		if (byName.isEmpty()) {
			throw new Exception("존재하지 않는 유저입니다.");
		}
		return personalRecordRepository.findByUserDto_IdAndWorkoutDto_Name(
			userId, workoutName);
	}
}
