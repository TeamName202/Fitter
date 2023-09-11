package com.mk.fitter.api.dailyrecord.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.dailyrecord.repository.dto.DailyRecordDetailDto;

@Repository
public interface DailyRecordDetailRepository extends JpaRepository<DailyRecordDetailDto, Integer> {

}
