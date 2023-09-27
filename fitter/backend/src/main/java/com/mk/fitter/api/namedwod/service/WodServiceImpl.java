package com.mk.fitter.api.namedwod.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.mk.fitter.api.namedwod.repository.WodCategoryRepository;
import com.mk.fitter.api.namedwod.repository.WodRecordRepository;
import com.mk.fitter.api.namedwod.repository.WodRepository;
import com.mk.fitter.api.namedwod.repository.dto.WodCategoryDto;
import com.mk.fitter.api.namedwod.repository.dto.WodDto;
import com.mk.fitter.api.namedwod.repository.dto.WodRecordCreateRequest;
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
	private final WodCategoryRepository wodCategoryRepository;

	@Override
	public List<WodRecordDto> getNamedWodList(int userId, String namedWodName) {
		WodDto byName = wodRepository.findByName(namedWodName);
		List<WodRecordDto> byWodId = wodRecordRepository.findByWod_IdAndUser_IdOrderByCreateDateDesc(
			byName.getId(), userId);
		return byWodId;
	}

	@Override
	public List<WodCategoryDto> getWodCategory() {
		return wodCategoryRepository.findAll();
	}

	@Override
	public List<WodDto> getWodListByCategory(String category) {
		return wodRepository.findByWodCategoryDto_Category(category);
	}

	public boolean createWodRecord(WodRecordCreateRequest wodRecordCreateRequest, int userId) throws Exception {
		Optional<UserDto> byId = userRepository.findById(userId);
		if (byId.isEmpty()) {
			throw new Exception("존재하지 않는 회원입니다.");
		}
		Optional<WodDto> wodOp = wodRepository.findById(wodRecordCreateRequest.getWodId());
		if (wodOp.isEmpty()) {
			throw new Exception("존재하지 않는 와드입니다.");
		}
		WodRecordDto build = WodRecordDto.builder()
			.wod(wodOp.get())
			.createDate(wodRecordCreateRequest.getCreateDate())
			.count(wodRecordCreateRequest.getCount())
			.time(wodRecordCreateRequest.getTime())
			.user(byId.get())
			.build();
		wodRecordRepository.save(build);
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
	public boolean modifyWodRecord(int wodRecordId, WodRecordDto time, int userId) throws Exception {
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
		if (!modifyWod.getTime().equals(time.getTime())) {
			modifyWod.setTime(time.getTime());
		}
		if (modifyWod.getCount() != time.getCount()) {
			modifyWod.setCount(time.getCount());
		}
		wodRecordRepository.save(modifyWod);
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
