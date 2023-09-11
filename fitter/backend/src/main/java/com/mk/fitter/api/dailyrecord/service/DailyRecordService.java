package com.mk.fitter.api.dailyrecord.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Month;
import java.util.List;

import com.mk.fitter.api.dailyrecord.repository.dto.DailyRecordDto;

public interface DailyRecordService {
	List<DailyRecordDto> getAllRecordsByMonth(int userId, LocalDate startDate, LocalDate endDate);
}
