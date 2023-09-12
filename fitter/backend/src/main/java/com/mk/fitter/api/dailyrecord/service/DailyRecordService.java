package com.mk.fitter.api.dailyrecord.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import com.mk.fitter.api.dailyrecord.repository.dto.DailyRecordDto;

public interface DailyRecordService {
	List<DailyRecordDto> getAllRecordsByMonth(int userId, LocalDate startDate, LocalDate endDate);

	boolean writeDailyRecord(DailyRecordDto dailyRecordDto) throws Exception;

	DailyRecordDto getDailyRecordByDate(LocalDate date, int userId);

	boolean deleteDailyRecord(int dailyRecordId);

	boolean modifyDailyRecord(int dailyRecordId, Map<String, String> memo) throws Exception;
}
