package com.mk.fitter.api.namedwod.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mk.fitter.api.namedwod.repository.WodRecordRepository;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WodRecordServiceImpl implements WodRecordService {

	private final WodRecordRepository wodRecordRepository;

	@Override
	public List<WodRecordDto> getWodRecordList(Integer userId) {
		return wodRecordRepository.findByUser_Id(userId);
	}
}
