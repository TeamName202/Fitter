package com.mk.fitter.api.file.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.mk.fitter.api.file.repository.dto.ProfileImgDto;

@Repository
public interface ProfileImgRepository extends JpaRepository<ProfileImgDto, Integer> {

}
