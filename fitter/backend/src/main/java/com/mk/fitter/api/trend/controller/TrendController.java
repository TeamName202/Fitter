package com.mk.fitter.api.trend.controller;

import com.mk.fitter.api.trend.dto.HealthWordDto;
import com.mk.fitter.api.trend.dto.SportWordDto;
import com.mk.fitter.api.trend.service.TrendService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/trend")
@RestController
public class TrendController {

    private final TrendService trendService;

    // 크로스핏 인지도 순위
    @GetMapping("crossfit-rank")
    public ResponseEntity<List<SportWordDto>> getAllSports(){
        List<SportWordDto> responseDto = trendService.getAllSports();
        return new ResponseEntity<>(responseDto, HttpStatus.OK);
    }

    // 건강 키워드 순위
    @GetMapping("health")
    public ResponseEntity<List<HealthWordDto>> getAllHealths(){
        List<HealthWordDto> responseDto = trendService.getAllHealths();
        return new ResponseEntity<>(responseDto, HttpStatus.OK);
    }


}
