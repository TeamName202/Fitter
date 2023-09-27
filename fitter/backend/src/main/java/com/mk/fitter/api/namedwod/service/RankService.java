package com.mk.fitter.api.namedwod.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

public interface RankService {
	Page<WodRecordDto> getRanks(String wodName, Pageable pageable) throws Exception;

	WodRecordDto getMyRank(String wodName, String accessToken) throws Exception;
}
