package com.mk.fitter.api.trend.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.trend.entity.HealthWord;

@Repository
public interface HealthWordRepository extends JpaRepository<HealthWord, Integer> {

	List<HealthWord> findTop5ByOrderByCountDesc();
}
