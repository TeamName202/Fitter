package com.mk.fitter.api.box.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.mk.fitter.api.box.repository.BoxRepository;
import com.mk.fitter.api.box.repository.dto.BoxDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoxServiceImpl implements BoxService {

	private final BoxRepository boxRepository;

	@Override
	public List<BoxDto> getBoxList() {
		return boxRepository.findAll();
	}
}
