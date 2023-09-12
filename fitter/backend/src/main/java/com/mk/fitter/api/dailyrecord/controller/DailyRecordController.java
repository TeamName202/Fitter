package com.mk.fitter.api.dailyrecord.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

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

	@GetMapping("")
	public ResponseEntity<?> getAllRecordsByMonth(@RequestParam String date, @RequestHeader String accessToken) {
		try {
			/*
			jwt 구현되면 accessToken으로 유저 정보 가져오기 구현
			 */
			int userId = 1; // 임시 값
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
	public ResponseEntity<?> writeDailyRecord(@RequestBody DailyRecordDto dailyRecordDto) {
		boolean result = false;
		try {
			result = dailyRecordService.writeDailyRecord(dailyRecordDto);
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/read/{date}")
	public ResponseEntity<?> getDailyRecordByDate(@RequestHeader String accessToken, @PathVariable LocalDate date) {
		try {
			int userId = 1; // JWT 관련 기능 완성되면 수정할 것
			DailyRecordDto dailyRecordDto = dailyRecordService.getDailyRecordByDate(date, userId);
			return new ResponseEntity<>(dailyRecordDto, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/modify/{dailyRecordId}")
	public ResponseEntity<?> modifyDailyRecord(@PathVariable int dailyRecordId, @RequestBody Map<String, String> memo) {
		try {
			return new ResponseEntity<>(dailyRecordService.modifyDailyRecord(dailyRecordId, memo), HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@DeleteMapping("/delete/{dailyRecordId}")
	public ResponseEntity<?> deleteDailyRecord(@PathVariable int dailyRecordId) {
		boolean result;
		try {
			result = dailyRecordService.deleteDailyRecord(dailyRecordId);
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
