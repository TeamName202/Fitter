package com.mk.fitter.api.dailyrecord.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;
import java.util.List;

import org.springframework.stereotype.Service;

import com.mk.fitter.api.dailyrecord.repository.DailyRecordRepository;
import com.mk.fitter.api.dailyrecord.repository.dto.DailyRecordDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DailyRecordServiceImpl implements DailyRecordService {

	private final DailyRecordRepository dailyRecordRepository;

	@Override
	public List<DailyRecordDto> getAllRecordsByMonth(int userId, LocalDate startDate, LocalDate endDate) {
		List<DailyRecordDto> byUserIdAndDateMonth = dailyRecordRepository.findByUser_IdAndDateBetween(userId, startDate, endDate);
		return byUserIdAndDateMonth;
	}
}
