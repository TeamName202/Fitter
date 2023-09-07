package com.mk.fitter.api.box.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.box.repository.dto.BoxDto;

@Repository
public interface BoxRepository extends JpaRepository<BoxDto, Integer> {
	List<BoxDto> findByBoxName(String name);
}
