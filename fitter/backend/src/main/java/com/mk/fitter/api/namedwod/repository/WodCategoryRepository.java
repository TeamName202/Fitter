package com.mk.fitter.api.namedwod.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.namedwod.repository.dto.WodCategoryDto;

@Repository
public interface WodCategoryRepository extends JpaRepository<WodCategoryDto, Integer> {

}
