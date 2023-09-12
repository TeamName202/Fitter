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
import com.mk.fitter.api.namedwod.repository.dto.WodDto;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;
import com.mk.fitter.api.namedwod.service.WodService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/named-wod")
@RequiredArgsConstructor
@Slf4j
public class WodController {

	private final WodService wodService;
	private final JwtService jwtService;

	@GetMapping("/list/{namedWodName}")
	public ResponseEntity<List<WodRecordDto>> getNamedWodRecordList(@PathVariable String namedWodName) {
		try {
			List<WodRecordDto> namedWodList = wodService.getNamedWodList(namedWodName);
			return new ResponseEntity<>(namedWodList, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	@GetMapping("/list")
	public ResponseEntity<List<WodDto>> getWodList() {

		try {
			List<WodDto> wodRecordList = wodService.getWodList();
			return new ResponseEntity<>(wodRecordList, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/read/{wodRecordId}")
	public ResponseEntity<WodRecordDto> getWodRecord(@PathVariable int wodRecordId) {
		try {
			return new ResponseEntity<>(wodService.getWodRecord(wodRecordId), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/create")
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

	@PutMapping("/modify/{wodRecordId}")
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

	@DeleteMapping("/delete/{wodRecordId}")
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
