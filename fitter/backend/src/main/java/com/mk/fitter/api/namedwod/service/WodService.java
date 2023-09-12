package com.mk.fitter.api.namedwod.service;

import java.time.LocalTime;
import java.util.List;

import com.mk.fitter.api.namedwod.repository.dto.WodDto;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

public interface WodService {
	boolean createWodRecord(WodRecordDto wodRecordDto, int userId) throws Exception;

	List<WodDto> getWodList();

	WodRecordDto getWodRecord(int wodRecordId) throws Exception;

	boolean modifyWodRecord(int wodId, LocalTime time, int userId) throws Exception;

	boolean deleteWodRecord(int wodId, int userId) throws Exception;

	List<WodRecordDto> getNamedWodList(String namedWodName);
}
