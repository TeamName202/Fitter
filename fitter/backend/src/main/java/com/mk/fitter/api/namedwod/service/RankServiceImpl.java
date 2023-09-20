package com.mk.fitter.api.namedwod.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.mk.fitter.api.namedwod.repository.WodRecordRepository;
import com.mk.fitter.api.namedwod.repository.WodRepository;
import com.mk.fitter.api.namedwod.repository.dto.WodDto;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class RankServiceImpl implements RankService {

	private final WodRepository wodRepository;
	private final WodRecordRepository wodRecordRepository;

	@Override
	public Page<WodRecordDto> getRanks(String wodName, Pageable pageable) throws Exception {
		WodDto wodDto = wodRepository.findByName(wodName);
		if(wodDto == null) return null;
		return wodRecordRepository.findRankById(wodDto.getId(), pageable);
	}
}
