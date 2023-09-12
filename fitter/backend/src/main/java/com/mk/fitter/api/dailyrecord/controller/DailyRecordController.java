package com.mk.fitter.api.dailyrecord.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.common.service.JwtService;
import com.mk.fitter.api.dailyrecord.repository.dto.DailyRecordDto;
import com.mk.fitter.api.dailyrecord.service.DailyRecordService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/calendar")
@RequiredArgsConstructor
@Slf4j
public class DailyRecordController {

	private final DailyRecordService dailyRecordService;
	private final JwtService jwtService;

	@GetMapping("")
	public ResponseEntity<List<DailyRecordDto>> getAllRecordsByMonth(@RequestParam String date,
		@RequestHeader String Authorization) {
		try {
			/*
			jwt 구현되면 accessToken으로 유저 정보 가져오기 구현
			 */
			Optional<Integer> UID = jwtService.extractUID(Authorization);
			int userId = UID.get(); // 임시 값
			String[] dateSplit = date.split("-");
			LocalDate startDate = LocalDate.of(Integer.parseInt(dateSplit[0]), Integer.parseInt(dateSplit[1]), 1);
			LocalDate endDate = startDate.plusMonths(1).minusDays(1);
			System.out.println(startDate);
			System.out.println(endDate);
			List<DailyRecordDto> dailyRecordDtos = dailyRecordService.getAllRecordsByMonth(userId, startDate, endDate);
			return new ResponseEntity<>(dailyRecordDtos, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/write")
	public ResponseEntity<Boolean> writeDailyRecord(@RequestHeader String Authorization,
		@RequestBody DailyRecordDto dailyRecordDto) {
		Optional<Integer> UID = jwtService.extractUID(Authorization);
		boolean result = false;
		try {
			result = dailyRecordService.writeDailyRecord(dailyRecordDto, UID.get());
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/read/{date}")
	public ResponseEntity<DailyRecordDto> getDailyRecordByDate(@RequestHeader String Authorization,
		@PathVariable LocalDate date) {
		try {
			int userId = jwtService.extractUID(Authorization).get();
			DailyRecordDto dailyRecordDto = dailyRecordService.getDailyRecordByDate(date, userId);
			return new ResponseEntity<>(dailyRecordDto, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/modify/{dailyRecordId}")
	public ResponseEntity<Boolean> modifyDailyRecord(@PathVariable int dailyRecordId,
		@RequestBody Map<String, String> memo) {
		try {
			return new ResponseEntity<>(dailyRecordService.modifyDailyRecord(dailyRecordId, memo), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@DeleteMapping("/delete/{dailyRecordId}")
	public ResponseEntity<Boolean> deleteDailyRecord(@PathVariable int dailyRecordId,
		@RequestHeader String Authorization) {
		boolean result;
		try {
			Integer userId = jwtService.extractUID(Authorization).get();
			result = dailyRecordService.deleteDailyRecord(dailyRecordId, userId);
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
