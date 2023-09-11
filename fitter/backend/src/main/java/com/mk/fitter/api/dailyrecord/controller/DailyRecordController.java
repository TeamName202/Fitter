package com.mk.fitter.api.dailyrecord.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
			return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
