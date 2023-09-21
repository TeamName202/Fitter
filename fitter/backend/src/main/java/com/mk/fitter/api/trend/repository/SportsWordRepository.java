package com.mk.fitter.api.trend.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.trend.entity.SportsWord;

@Repository
public interface SportsWordRepository extends JpaRepository<SportsWord, Integer> {

	List<SportsWord> findAllByOrderByCountDesc();
}
