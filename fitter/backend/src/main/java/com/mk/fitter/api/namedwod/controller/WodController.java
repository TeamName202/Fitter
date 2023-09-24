package com.mk.fitter.api.namedwod.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.namedwod.repository.dto.WodCategoryDto;
import com.mk.fitter.api.namedwod.repository.dto.WodDto;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;
import com.mk.fitter.api.namedwod.service.WodRecordService;
import com.mk.fitter.api.namedwod.service.WodService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/named-wod")
@RequiredArgsConstructor
@Slf4j
@Api(tags = {"와드 API"})
public class WodController {

	private final WodService wodService;
	private final WodRecordService wodRecordService;
	private final JwtService jwtService;

	@GetMapping("/category")
	@ApiOperation(value = "와드 카테고리", notes = "와드 카테고리를 조회하는 API")
	public ResponseEntity<List<WodCategoryDto>> getWodCategory() {
		try {
			return new ResponseEntity<>(wodService.getWodCategory(), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/wod-record/list")
	@ApiOperation(value = "와드 기록 목록 조회", notes = "네임드 와드들의 모든 기록을 조회하는 API")
	public ResponseEntity<List<WodRecordDto>> getWodRecordList(@RequestHeader String Authorization) {
		try {
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			return new ResponseEntity<>(wodRecordService.getWodRecordList(UID.get()), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/wod-record/list/{namedWodName}")
	@ApiOperation(value = "네임드 와드 기록 리스트 조회", notes = "해당 네임드 와드의 기록들을 조회하는 API")
	public ResponseEntity<List<WodRecordDto>> getNamedWodRecordList(@RequestHeader String Authorization,
		@PathVariable String namedWodName) {
		try {
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			List<WodRecordDto> namedWodList = wodService.getNamedWodList(UID.get(), namedWodName);
			return new ResponseEntity<>(namedWodList, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	@GetMapping("/wod-record/list/test/{namedWodName}")
	@ApiOperation(value = "네임드 와드 기록 리스트 조회", notes = "해당 네임드 와드의 기록들을 조회하는 API")
	public ResponseEntity<List<WodRecordDto>> getNamedWodRecordListTest(@PathVariable String namedWodName) {
		try {
			List<WodRecordDto> namedWodList = wodService.getNamedWodList(28, namedWodName);
			return new ResponseEntity<>(namedWodList, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	@GetMapping("/list")
	@ApiOperation(value = "네임드 와드 리스트 조회", notes = "네임드 와드 목록을 조회하는 API")
	public ResponseEntity<List<WodDto>> getWodList() {
		try {
			List<WodDto> wodRecordList = wodService.getWodList();
			return new ResponseEntity<>(wodRecordList, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/wod-record/read/{wodRecordId}")
	@ApiOperation(value = "단일 와드 기록 조회", notes = "특정 와드 기록을 조회하는 API")
	public ResponseEntity<WodRecordDto> getWodRecord(@PathVariable int wodRecordId) {
		try {
			return new ResponseEntity<>(wodService.getWodRecord(wodRecordId), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/wod-record/create")
	@ApiOperation(value = "와드 기록 생성", notes = "와드 기록을 생성하는 API")
	public ResponseEntity<Boolean> createWodRecord(@RequestHeader String Authorization,
		@RequestBody WodRecordDto wodRecordDto) {
		// 토큰값으로 유저 가져오거나, 프론트에서 유저 id 받아야 함
		Optional<Integer> UID = jwtService.extractUID(Authorization);
		boolean result = false;
		try {
			result = wodService.createWodRecord(wodRecordDto, UID.get());
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/wod-record/modify/{wodRecordId}")
	@ApiOperation(value = "와드 기록 수정", notes = "와드 기록을 수정하는 API")

	public ResponseEntity<Boolean> modifyWodRecord(@RequestHeader String Authorization, @PathVariable int wodRecordId,
		@RequestBody WodRecordDto time) {

		Optional<Integer> UID = jwtService.extractUID(Authorization);
		boolean result = false;
		try {
			result = wodService.modifyWodRecord(wodRecordId, time.getTime(), UID.get());
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@DeleteMapping("/wod-record/delete/{wodRecordId}")
	@ApiOperation(value = "와드 기록 삭제", notes = "와드 기록을 삭제하는 API")
	public ResponseEntity<Boolean> deleteWodRecord(@RequestHeader String Authorization, @PathVariable int wodRecordId) {
		try {
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			return new ResponseEntity<>(wodService.deleteWodRecord(wodRecordId, UID.get()), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
