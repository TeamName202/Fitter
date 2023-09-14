package com.mk.fitter.api.trend.service;

import com.mk.fitter.api.trend.dto.HealthWordDto;
import com.mk.fitter.api.trend.dto.SportWordDto;
import com.mk.fitter.api.trend.repository.HealthWordRepository;
import com.mk.fitter.api.trend.repository.SportWordRepository;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class TrendService {

    private final SportWordRepository sportWordRepository;
    private final HealthWordRepository healthWordRepository;

    @Transactional(readOnly = true)
    public List<SportWordDto> getAllSports() {
        return  sportWordRepository.findAll().stream()
                .map(SportWordDto::new)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<HealthWordDto> getAllHealths() {
        return healthWordRepository.findAll().stream()
            .map(HealthWordDto::new)
            .collect(Collectors.toList());
    }

}
