package com.mk.fitter.api.personalrecord.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordDto;

@Repository
public interface PersonalRecordRepository extends JpaRepository<PersonalRecordDto, Integer> {

	List<PersonalRecordDto> findByUserDto_Id(int userId);

	boolean deleteById(int id);
}
