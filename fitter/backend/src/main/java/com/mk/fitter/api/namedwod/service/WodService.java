package com.mk.fitter.api.namedwod.service;

import java.time.LocalTime;
import java.util.List;

import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

public interface WodService {
	boolean createWodRecord(WodRecordDto wodRecordDto) throws Exception;

	List<WodRecordDto> getWodRecordList();

	WodRecordDto getWodRecord(int wodId) throws Exception;

	boolean modifyWodRecord(int wodId, LocalTime time) throws Exception;

	boolean deleteWodRecord(int wodId);
}
