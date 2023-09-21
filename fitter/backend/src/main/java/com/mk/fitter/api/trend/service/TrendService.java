package com.mk.fitter.api.trend.service;

import com.mk.fitter.api.trend.dto.HealthWordDto;
import com.mk.fitter.api.trend.dto.SportsWordDto;
import com.mk.fitter.api.trend.repository.HealthWordRepository;
import com.mk.fitter.api.trend.repository.SportsWordRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class TrendService {

    private final SportsWordRepository sportsWordRepository;
    private final HealthWordRepository healthWordRepository;

    @Transactional(readOnly = true)
    public List<SportsWordDto> getAllSports() {
        return  sportsWordRepository.findAllByOrderByCountDesc().stream()
                .map(SportsWordDto::new)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<HealthWordDto> getAllHealths() {
        return healthWordRepository.findAllByOrderByCountDesc().stream()
            .map(HealthWordDto::new)
            .collect(Collectors.toList());
    }

}
