package com.mk.fitter.api.trend.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.trend.entity.SportWord;

@Repository
public interface SportWordRepository extends JpaRepository<SportWord, Integer> {

}
