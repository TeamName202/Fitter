package com.mk.fitter.api.namedwod.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mk.fitter.api.namedwod.repository.dto.WodDto;

public interface WodRepository extends JpaRepository<WodDto, Integer> {
}
