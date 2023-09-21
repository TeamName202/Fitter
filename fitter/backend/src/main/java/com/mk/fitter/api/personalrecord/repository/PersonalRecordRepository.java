package com.mk.fitter.api.personalrecord.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordDto;

@Repository
public interface PersonalRecordRepository extends JpaRepository<PersonalRecordDto, Integer> {

	List<PersonalRecordDto> findByUserDto_Id(int userId);

	boolean deleteById(int id);

	@Query(value = "SELECT *FROM (SELECT *, RANK() over(PARTITION BY workout_id ORDER BY max_weight DESC) AS ranking FROM personal_record WHERE user_id = :userId) AS ranked_records WHERE ranking = 1;", nativeQuery = true)
	List<PersonalRecordDto> findRankByUserDto_Id(@Param("userId") int userId);

	List<PersonalRecordDto> findByUserDto_IdAndWorkoutDto_Name(int userId, String workoutName);

}
