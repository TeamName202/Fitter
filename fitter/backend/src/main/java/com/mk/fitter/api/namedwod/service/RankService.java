package com.mk.fitter.api.namedwod.service;

import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

public interface RankService {
	Page<Map<String, String>> getRanks(String wodName, Pageable pageable) throws Exception;

	Map<String, String> getMyRank(String wodName, String accessToken) throws Exception;
}
