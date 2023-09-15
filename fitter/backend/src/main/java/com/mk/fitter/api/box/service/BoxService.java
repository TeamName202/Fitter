package com.mk.fitter.api.box.service;

import java.util.List;

import com.mk.fitter.api.box.repository.dto.BoxDto;

public interface BoxService {

	List<BoxDto> getBoxList();

	boolean createBox(BoxDto boxDto);

	boolean deleteBox(int boxId) throws Exception;
}
