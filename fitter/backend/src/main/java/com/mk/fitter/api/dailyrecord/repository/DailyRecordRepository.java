package com.mk.fitter.api.dailyrecord.repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.dailyrecord.repository.dto.DailyRecordDto;

@Repository
public interface DailyRecordRepository extends JpaRepository<DailyRecordDto, Integer> {

	List<DailyRecordDto> findByUser_IdAndDateBetween(int user_id, LocalDate startDate, LocalDate endDate);

}
