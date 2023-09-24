package com.mk.fitter.api.personalrecord.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordDto;

@Repository
public interface PersonalRecordRepository extends JpaRepository<PersonalRecordDto, Integer> {

	List<PersonalRecordDto> findByUserDto_Id(int userId);

	boolean deleteById(int id);

	@Query(value = "SELECT workout.*, ranked_records.*\n" +
		"FROM workout\n" +
		"LEFT OUTER JOIN (\n" +
		"    SELECT pr.id as pr_id, pr.max_weight, pr.workout_id, RANK() OVER (PARTITION BY pr.workout_id ORDER BY pr.max_weight DESC) AS ranking\n"
		+
		"    FROM personal_record pr\n" +
		"    WHERE pr.user_id = :userId\n" +
		") AS ranked_records ON workout.id = ranked_records.workout_id\n" +
		"where ranking = 1 or ranking is null;", nativeQuery = true)
	List<Map<String, String>> findRankByUserDto_Id(@Param("userId") int userId);

	List<PersonalRecordDto> findByUserDto_IdAndWorkoutDto_Name(int userId, String workoutName);

}
