package com.mk.fitter.api.namedwod.controller;

import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;
import com.mk.fitter.api.namedwod.service.RankServiceImpl;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/rank")
@Api(tags = {"와드 랭킹 API"})
public class RankController {
	private final RankServiceImpl rankService;

	@GetMapping("/{wodName}")
	@ApiOperation(value = "와드 랭킹 api", notes = "ex) /rank/kelly?page=1&size=50, size는 default로 50이 되어있어서 안보내도 괜찮음. page는 0부터 시작함")
	public ResponseEntity<Page<Map<String, String>>> getRank(@PathVariable(name = "wodName") String wodName,
		@PageableDefault(size = 50) Pageable pageable,
		@RequestHeader(name = "Authorization") String accessToken) {
		try {
			Page<Map<String, String>> ranks = rankService.getRanks(wodName, pageable);
			return new ResponseEntity<>(ranks, HttpStatus.OK);
		} catch (Exception e) {
			log.error("getRank :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/my-rank/{wodName}")
	@ApiOperation(value = "내 와드 랭킹", notes = "내 와드 랭킹을 조회하는 API")
	public ResponseEntity<Map<String, String>> getMyRank(@PathVariable(name = "wodName") String wodName, @RequestHeader(name = "Authorization") String accessToken) {
		try {
			return new ResponseEntity<>(rankService.getMyRank(wodName, accessToken), HttpStatus.OK);
		} catch (Exception e) {
			log.error("getMyRank :: {}", e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
