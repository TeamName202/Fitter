package com.mk.fitter.api.trend.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.trend.dto.HealthNewsDto;
import com.mk.fitter.api.trend.dto.HealthWordDto;
import com.mk.fitter.api.trend.dto.SportsWordDto;
import com.mk.fitter.api.trend.service.TrendService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RequestMapping("/trend")
@RestController
@Api(tags = {"트렌드 키워드 API"})
public class TrendController {

	private final TrendService trendService;

	// 크로스핏 인지도 순위
	@GetMapping("/sports")
	@ApiOperation(value = "스포츠 키워드", notes = "모든 스포츠 키워드를 조회하는 API")
	public ResponseEntity<List<SportsWordDto>> getAllSports() {
		List<SportsWordDto> responseDto = trendService.getAllSports();
		return new ResponseEntity<>(responseDto, HttpStatus.OK);
	}

	// 건강 키워드 순위
	@GetMapping("/health")
	@ApiOperation(value = "건강 키워드", notes = "인기 건강 키워드 5개 조회하는 API")
	public ResponseEntity<List<HealthWordDto>> getTop5Healths() {
		List<HealthWordDto> responseDto = trendService.getTop5Healths();
		return new ResponseEntity<>(responseDto, HttpStatus.OK);
	}

	// 건강 뉴스 조회
	@GetMapping("/health/search")
	@ApiOperation(value = "건강 키워드 뉴스", notes = "지정된 건강 키워드의 뉴스 5개 조회")
	public ResponseEntity<List<HealthNewsDto>> getHealthNews(@RequestParam String keyword){
		List<HealthNewsDto> responseDto = trendService.getHealthNews(keyword);
		return new ResponseEntity<>(responseDto, HttpStatus.OK);
	}

}
