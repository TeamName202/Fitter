package com.mk.fitter.api.personalrecord.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordDto;

@Repository
public interface PersonalRecordRepository extends JpaRepository<PersonalRecordDto, Integer> {

	List<PersonalRecordDto> findByUserDto_Id(int userId);

	boolean deleteById(int id);

	@Query(value = "SELECT *, RANK() over(partition by workout_id ORDER BY max_weight DESC) AS ranking FROM personal_record where WHERE user_id = :userId limit 1", nativeQuery = true)
	List<PersonalRecordDto> findRankByUserDto_Id(int userId);

}
