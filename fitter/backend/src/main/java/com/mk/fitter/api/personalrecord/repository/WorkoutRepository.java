package com.mk.fitter.api.personalrecord.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.personalrecord.repository.dto.WorkoutDto;

@Repository
public interface WorkoutRepository extends JpaRepository<WorkoutDto, Integer> {
	Optional<WorkoutDto> findByName(String name);
}
