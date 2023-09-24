package com.mk.fitter.api.personalrecord.service;

import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordCreateRequest;
import com.mk.fitter.api.personalrecord.repository.dto.PersonalRecordDto;
import com.mk.fitter.api.personalrecord.repository.dto.WorkoutDto;
import com.mk.fitter.api.personalrecord.repository.dto.WorkoutTypeDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface PersonalRecordService {
    List<PersonalRecordDto> getRecordList(Integer userId);

    PersonalRecordDto getRecord(int personalRecordId) throws Exception;

    boolean creatRecord(Integer userId, PersonalRecordCreateRequest requestBody) throws Exception;

    boolean modifyRecord(Integer userId, HashMap<String, Integer> requestBody, int personalRecordId) throws Exception;

    Boolean deleteRecord(int personalRecordId, Integer userId) throws Exception;

    List<WorkoutTypeDto> getWorkoutCategory();

    List<WorkoutDto> getWorkoutList();

    List<Map<String, String>> getRankList(Integer userId);

    List<PersonalRecordDto> getRecordListByWorkoutName(Integer userId, String workoutName) throws Exception;
}
