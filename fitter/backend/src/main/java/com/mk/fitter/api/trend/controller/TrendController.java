package com.mk.fitter.api.trend.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.trend.dto.HealthWordDto;
import com.mk.fitter.api.trend.dto.SportWordDto;
import com.mk.fitter.api.trend.service.TrendService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/trend")
@RestController
@Api(tags = {"트렌트 키워드 API"})
public class TrendController {

	private final TrendService trendService;

	// 크로스핏 인지도 순위
	@GetMapping("crossfit-rank")
	@ApiOperation(value = "스포츠 키워드", notes = "모든 스포츠 키워드를 조회하는 API")
	public ResponseEntity<List<SportWordDto>> getAllSports() {
		List<SportWordDto> responseDto = trendService.getAllSports();
		return new ResponseEntity<>(responseDto, HttpStatus.OK);
	}

	// 건강 키워드 순위
	@GetMapping("health")
	@ApiOperation(value = "건강 키워드", notes = "모든 건강 키워드를 조회하는 API")
	public ResponseEntity<List<HealthWordDto>> getAllHealths() {
		List<HealthWordDto> responseDto = trendService.getAllHealths();
		return new ResponseEntity<>(responseDto, HttpStatus.OK);
	}

}
