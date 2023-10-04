package com.mk.fitter.api.namedwod.service;

import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.mk.fitter.api.namedwod.repository.dto.WodRankDto;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

public interface RankService {
	Page<WodRecordDto> getRanks(String wodName, Pageable pageable) throws Exception;

	WodRankDto getMyRank(String wodName, String accessToken) throws Exception;
}
