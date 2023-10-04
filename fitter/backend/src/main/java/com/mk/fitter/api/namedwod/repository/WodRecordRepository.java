package com.mk.fitter.api.namedwod.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.namedwod.repository.dto.WodRecordDto;

@Repository
public interface WodRecordRepository extends JpaRepository<WodRecordDto, Integer> {
	List<WodRecordDto> findAll();

	boolean deleteById(int wodRecordId);

	List<WodRecordDto> findByWod_Id(int wodId);

	List<WodRecordDto> findByWod_IdAndUser_IdOrderByCreateDateDesc(int wodId, int userId);

	List<WodRecordDto> findByUser_Id(int userId);

	@Query(value = "SELECT *, RANK() over(ORDER BY time ASC) AS ranking FROM wod_record WHERE wod_id = :wodId", nativeQuery = true)
	Page<Map<String, String>> findRankById(int wodId, Pageable pageable);

	@Query(value = "SELECT *, RANK() OVER(ORDER BY TIME ASC) AS ranking FROM wod_record WHERE wod_id = :wodId and user_id = :userId limit 1", nativeQuery = true)
	Map<String, String> findRankByIdAndUserId(int wodId, int userId);
}
