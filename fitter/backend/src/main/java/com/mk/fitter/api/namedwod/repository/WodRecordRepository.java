package com.mk.fitter.api.namedwod.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

@Repository
public interface WodRecordRepository extends JpaRepository<WodRecordDto, Integer> {
	List<WodRecordDto> findAll();

	WodRecordDto findByWod_IdAndUser_Id(int wodId, int userId);

	boolean deleteById(int wodRecordId);

	List<WodRecordDto> findByWod_Id(int wodId);

	List<WodRecordDto> findByUser_Id(int userId);

	@Query(value = "SELECT *, RANK() over(ORDER BY time ASC) AS ranking FROM wod WHERE id = :id", nativeQuery = true)
	Page<WodRecordDto> findRankById(int id, Pageable pageable);
}
