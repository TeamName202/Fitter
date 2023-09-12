package com.mk.fitter.api.namedwod.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.namedwod.repository.dto.WodDto;

@Repository
public interface WodRepository extends JpaRepository<WodDto, Integer> {

	WodDto findByName(String name);

	List<WodDto> findByNamedIs(boolean isNamed);
}
