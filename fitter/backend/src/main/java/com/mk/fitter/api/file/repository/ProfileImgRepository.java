package com.mk.fitter.api.file.repository;

import org.hibernate.annotations.DynamicInsert;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.file.repository.dto.ProfileImgDto;

@Repository
@DynamicInsert
public interface ProfileImgRepository extends JpaRepository<ProfileImgDto, Integer> {

}
