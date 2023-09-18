package com.mk.fitter.api.namedwod.service;

import java.util.List;

import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

public interface WodRecordService {
	List<WodRecordDto> getWodRecordList(Integer userId);
}
