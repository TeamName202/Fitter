package com.mk.fitter.api.namedwod.service;

import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.mk.fitter.api.namedwod.repository.WodRecordRepository;
import com.mk.fitter.api.namedwod.repository.WodRepository;
import com.mk.fitter.api.namedwod.repository.dto.WodDto;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;
import com.mk.fitter.api.user.repository.UserRepository;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class WodServiceImpl implements WodService {

	private final WodRecordRepository wodRecordRepository;
	private final UserRepository userRepository;
	private final WodRepository wodRepository;

	@Override
	public List<WodRecordDto> getNamedWodList(String namedWodName) {
		WodDto byName = wodRepository.findByName(namedWodName);
		List<WodRecordDto> byWodId = wodRecordRepository.findByWod_Id(byName.getId());
		return byWodId;
	}

	public boolean createWodRecord(WodRecordDto wodRecordDto, int userId) throws Exception {
		Optional<UserDto> byId = userRepository.findById(userId);
		if (byId.isEmpty()) {
			throw new Exception("존재하지 않는 회원입니다.");
		}
		WodRecordDto byWodIdAndUserId = wodRecordRepository.findByWod_IdAndUser_Id(wodRecordDto.getWod().getId(),
			byId.get().getId());
		if (byWodIdAndUserId != null) {
			throw new Exception("이미 존재하는 기록입니다.");
		} else {
			wodRecordRepository.save(wodRecordDto);
		}
		return true;
	}

	@Override
	public List<WodDto> getWodList() {
		return wodRepository.findByIsNamedIs(true);
	}

	@Override
	public WodRecordDto getWodRecord(int wodRecordId) throws Exception {
		Optional<WodRecordDto> byId = wodRecordRepository.findById(wodRecordId);
		if (byId.isPresent()) {
			return byId.get();
		} else {
			throw new Exception("와드 Id를 확인하세요");
		}
	}

	@Override
	public boolean modifyWodRecord(int wodRecordId, LocalTime time, int userId) throws Exception {
		Optional<UserDto> byId = userRepository.findById(userId);
		if (byId.isEmpty()) {
			throw new Exception("존재하지 않는 회원입니다.");
		}
		Optional<WodRecordDto> foundWod = wodRecordRepository.findById(wodRecordId);

		if (foundWod.isEmpty()) {
			throw new Exception("와드 기록이 존재하지 않습니다.");
		}
		WodRecordDto modifyWod = foundWod.get();
		if (modifyWod.getUser().getId() != userId) {
			throw new Exception("본인이 작성한 기록이 아닙니다.");
		}
		modifyWod.setTime(time);
		return true;
	}

	@Override
	public boolean deleteWodRecord(int wodRecordId, int userId) throws Exception {
		Optional<UserDto> findUser = userRepository.findById(userId);
		if (findUser.isEmpty()) {
			throw new Exception("존재하지 않는 회원입니다.");
		}
		Optional<WodRecordDto> findWod = wodRecordRepository.findById(wodRecordId);
		if (findWod.isEmpty()) {
			throw new Exception("존재하지 않는 기록입니다.");
		}
		if (userId != findWod.get().getUser().getId()) {
			throw new Exception("본인이 작성한 기록이 아닙니다.");
		}
		return wodRecordRepository.deleteById(wodRecordId);
	}

}
