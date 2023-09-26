package com.mk.fitter.api.namedwod.service;

import java.time.LocalTime;
import java.util.List;

import com.mk.fitter.api.namedwod.repository.dto.WodCategoryDto;
import com.mk.fitter.api.namedwod.repository.dto.WodDto;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordCreateRequest;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

public interface WodService {
	boolean createWodRecord(WodRecordCreateRequest wodRecordCreateRequest, int userId) throws Exception;

	List<WodDto> getWodList();

	WodRecordDto getWodRecord(int wodRecordId) throws Exception;

	boolean modifyWodRecord(int wodId, LocalTime time, int userId) throws Exception;

	boolean deleteWodRecord(int wodId, int userId) throws Exception;

	List<WodRecordDto> getNamedWodList(int userId, String namedWodName);

	List<WodCategoryDto> getWodCategory();

	List<WodDto> getWodListByCategory(String category);
}
