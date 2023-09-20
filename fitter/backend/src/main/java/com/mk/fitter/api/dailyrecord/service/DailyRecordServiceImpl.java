package com.mk.fitter.api.dailyrecord.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.mk.fitter.api.dailyrecord.repository.DailyRecordDetailRepository;
import com.mk.fitter.api.dailyrecord.repository.DailyRecordRepository;
import com.mk.fitter.api.dailyrecord.repository.dto.DailyRecordDetailDto;
import com.mk.fitter.api.dailyrecord.repository.dto.DailyRecordDto;
import com.mk.fitter.api.user.repository.UserRepository;
import com.mk.fitter.api.user.repository.dto.UserDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DailyRecordServiceImpl implements DailyRecordService {

	private final DailyRecordRepository dailyRecordRepository;
	private final UserRepository userRepository;
	private final DailyRecordDetailRepository dailyRecordDetailRepository;

	@Override
	public List<DailyRecordDto> getAllRecordsByMonth(int userId, LocalDate startDate, LocalDate endDate) {
		List<DailyRecordDto> byUserIdAndDateMonth = dailyRecordRepository.findByUserDto_IdAndDateBetween(userId,
			startDate, endDate);
		return byUserIdAndDateMonth;
	}

	@Override
	public List<DailyRecordDto> getAllRecordsByMonthForTest(LocalDate startDate, LocalDate endDate) {
		List<DailyRecordDto> byUserIdAndDateMonth = dailyRecordRepository.findByDateBetween(
			startDate, endDate);
		return byUserIdAndDateMonth;
	}

	@Override
	public boolean writeDailyRecord(DailyRecordDto dailyRecordDto, int userId) throws Exception {
		Optional<UserDto> byId = userRepository.findById(userId);
		if (!byId.isPresent()) {
			throw new Exception("유저가 없습니다.");
		}
		dailyRecordDto.setUserDto(byId.get());
		DailyRecordDto save = dailyRecordRepository.save(dailyRecordDto);
		for (DailyRecordDetailDto temp : dailyRecordDto.getDailyRecordDetails()) {
			temp.setDailyRecordDto(save);
			dailyRecordDetailRepository.save(temp);
		}
		return true;
	}

	@Override
	public DailyRecordDto getDailyRecordByDate(LocalDate date, int userId) {
		return dailyRecordRepository.findByDateAndUserDto_Id(date, userId);
	}

	@Override
	public boolean deleteDailyRecord(int dailyRecordId, int userId) throws Exception {
		Optional<UserDto> findUser = userRepository.findById(userId);
		Optional<DailyRecordDto> findRecord = dailyRecordRepository.findById(dailyRecordId);
		if (findUser.isEmpty()) {
			throw new Exception("유저를 확인해 주세요");
		}
		if (findRecord.isEmpty()) {
			throw new Exception("기록 Id를 확인해 주세요");
		}
		if (findRecord.get().getUserDto().getId() != userId) {
			throw new Exception("본인이 작성한 기록이 아닙니다.");
		}
		return dailyRecordRepository.deleteById(dailyRecordId);
	}

	@Override
	public boolean modifyDailyRecord(int dailyRecordId, Map<String, String> memo) throws Exception {
		Optional<DailyRecordDto> byId = dailyRecordRepository.findById(dailyRecordId);
		if (byId.isPresent()) {
			DailyRecordDto dailyRecordDto = byId.get();
			dailyRecordDto.setMemo(memo.get("memo"));
			dailyRecordRepository.save(dailyRecordDto);
			return true;
		} else {
			throw new Exception("수정에 실패했습니다.");
		}
	}

	@Override
	public boolean writeDailyRecordTest(DailyRecordDto dailyRecordDto) throws Exception {
		Optional<UserDto> byId = userRepository.findById(28);
		if (!byId.isPresent()) {
			throw new Exception("유저가 없습니다.");
		}
		dailyRecordDto.setUserDto(byId.get());
		DailyRecordDto save = dailyRecordRepository.save(dailyRecordDto);
		for (DailyRecordDetailDto temp : dailyRecordDto.getDailyRecordDetails()) {
			temp.setDailyRecordDto(save);
			dailyRecordDetailRepository.save(temp);
		}
		return true;
	}
}
