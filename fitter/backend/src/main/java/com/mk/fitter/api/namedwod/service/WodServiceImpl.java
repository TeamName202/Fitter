package com.mk.fitter.api.namedwod.service;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.mk.fitter.api.namedwod.repository.WodRecordRepository;
import com.mk.fitter.api.namedwod.repository.WodRepository;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;
import com.mk.fitter.api.user.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WodServiceImpl implements WodService {

	private final WodRecordRepository wodRecordRepository;
	private final UserRepository userRepository;
	private final WodRepository wodRepository;

	public boolean createWodRecord(WodRecordDto wodRecordDto) throws Exception {
		WodRecordDto byWodIdAndUserId = wodRecordRepository.findByWod_IdAndUser_Id(wodRecordDto.getWod().getId(),
			wodRecordDto.getUser().getId());
		if (byWodIdAndUserId != null) {
			throw new Exception("이미 존재하는 기록입니다.");
		} else {
			wodRecordRepository.save(wodRecordDto);
		}
		return true;
	}

	@Override
	public List<WodRecordDto> getWodRecordList() {
		return wodRecordRepository.findAll();
	}

	@Override
	public WodRecordDto getWodRecord(int wodId) throws Exception {
		Optional<WodRecordDto> byId = wodRecordRepository.findById(wodId);
		if (byId.isPresent()) {
			return byId.get();
		} else {
			throw new Exception("와드 Id를 확인하세요");
		}
	}

	@Override
	public boolean modifyWodRecord(int wodRecordId, LocalTime time) throws Exception {
		Optional<WodRecordDto> foundWod = wodRecordRepository.findById(wodRecordId);
		if (foundWod.isPresent()) {
			WodRecordDto modifyWod = foundWod.get();
			modifyWod.setTime(time);
			return true;
		} else {
			throw new Exception("와드 기록이 존재하지 않습니다.");
		}
	}

	@Override
	public boolean deleteWodRecord(int wodRecordId) {
		return wodRecordRepository.deleteById(wodRecordId);
	}
}
