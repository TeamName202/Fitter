package com.mk.fitter.api.personalrecord.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordDto;
import com.mk.fitter.api.personalrecord.service.PersonalRecordService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/record")
@Slf4j
public class PersonalRecordController {

	private final PersonalRecordService personalRecordService;
	private final JwtService jwtService;

	@GetMapping("/list")
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
	public ResponseEntity<Boolean> createRecord(@RequestHeader String Authorization,
		@RequestBody HashMap<String, String> requestBody) {
		try {
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			boolean result = personalRecordService.creatRecord(UID.get(), requestBody);
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
