package com.mk.fitter.api.personalrecord.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordCreateRequest;
import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordDto;
import com.mk.fitter.api.personalrecord.repository.dto.WorkoutDto;
import com.mk.fitter.api.personalrecord.repository.dto.WorkoutTypeDto;
import com.mk.fitter.api.personalrecord.service.PersonalRecordService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/record")
@Api(tags = {"1RM API"})
@Slf4j
public class PersonalRecordController {

	private final PersonalRecordService personalRecordService;
	private final JwtService jwtService;

	@GetMapping("/category")
	@ApiOperation(value = "운동 대분류 리스트", notes = "운동 대분류 리스트 불러오는 API")
	public ResponseEntity<List<WorkoutTypeDto>> getWorkoutCategory() {
		try {
			List<WorkoutTypeDto> category = personalRecordService.getWorkoutCategory();
			return new ResponseEntity<>(category, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/list/rank")
	@ApiOperation(value = "각 운동별 최고 기록", notes = "각 운동별 최고 기록을 리스트로 제공하는 API")
	public ResponseEntity<List<PersonalRecordDto>> getRankList(@RequestHeader String Authorization) {
		try {
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			return new ResponseEntity<>(personalRecordService.getRankList(UID.get()), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	@GetMapping("/workout")
	@ApiOperation(value = "운동 목록 조회", notes = "운동 목록 리스트를 조회하는 API")
	public ResponseEntity<List<WorkoutDto>> getWorkoutList() {
		try {
			return new ResponseEntity<>(personalRecordService.getWorkoutList(), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/list")
	@ApiOperation(value = "1RM 기록 리스트", notes = "개인의 1RM리스트를 조회하는 API")
	public ResponseEntity<List<PersonalRecordDto>> getRecordList(@RequestHeader String Authorization) {
		try {
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			List<PersonalRecordDto> result = personalRecordService.getRecordList(UID.get());
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/read/{personalRecordId}")
	@ApiOperation(value = "1RM 단일 기록 조회", notes = "1RM 기록의 세부사항을 조회하는 API")
	public ResponseEntity<PersonalRecordDto> getRecord(@PathVariable int personalRecordId) {
		try {
			PersonalRecordDto result = personalRecordService.getRecord(personalRecordId);
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/create")
	@ApiOperation(value = "1RM 기록 생성", notes = "1RM 기록을 생성하는 API")
	@ApiModelProperty(example = "{\"workoutName\":\"Squat\",\"maxWeight\":100}")
	public ResponseEntity<Boolean> createRecord(@RequestHeader String Authorization,
		@RequestBody PersonalRecordCreateRequest requestBody) {
		try {
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			boolean result = personalRecordService.creatRecord(UID.get(), requestBody);
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/modify/{personalRecordId}")
	@ApiOperation(value = "1RM 기록 수정", notes = "1RM 기록을 수정하는 API")
	public ResponseEntity<Boolean> modifyRecord(@PathVariable int personalRecordId,
		@RequestHeader String Authorization, @RequestBody HashMap<String, Integer> requestBody) {
		try {
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			boolean result = personalRecordService.modifyRecord(UID.get(), requestBody, personalRecordId);
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@DeleteMapping("/delete/{personalRecordId}")
	@ApiOperation(value = "1RM 기록 삭제", notes = "1RM 기록을 삭제하는 API")
	public ResponseEntity<Boolean> deleteRecord(@PathVariable int personalRecordId,
		@RequestHeader String Authorization) {
		try {
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			return new ResponseEntity<>(personalRecordService.deleteRecord(personalRecordId, UID.get()), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
