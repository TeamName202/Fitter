package com.mk.fitter.api.namedwod.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.namedwod.repository.dto.WodDto;

@Repository
public interface WodRepository extends JpaRepository<WodDto, Integer> {
}
