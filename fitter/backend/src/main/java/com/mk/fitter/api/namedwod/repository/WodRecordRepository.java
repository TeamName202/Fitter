package com.mk.fitter.api.namedwod.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.namedwod.repository.entity.WodRecordDto;

@Repository
public interface WodRecordRepository extends JpaRepository<WodRecordDto, Integer> {
	List<WodRecordDto> findAll();

	WodRecordDto findByWod_IdAndUser_Id(int wodId, int userId);

}
