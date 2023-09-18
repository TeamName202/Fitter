package com.mk.fitter.api.personalrecord.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.personalrecord.repository.dto.WorkoutTypeDto;

@Repository
public interface WorkoutTypeRepository extends JpaRepository<WorkoutTypeDto, Integer> {
}
