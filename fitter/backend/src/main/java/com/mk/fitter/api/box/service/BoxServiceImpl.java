package com.mk.fitter.api.box.service;

import java.util.List;
import java.util.Optional;

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

	@Override
	public boolean createBox(BoxDto boxDto) {
		boxRepository.save(boxDto);
		return true;
	}

	@Override
	public boolean deleteBox(int boxId) throws Exception {
		Optional<BoxDto> findBox = boxRepository.findById(boxId);
		if (findBox.isEmpty()) {
			throw new Exception("존재하지 않는 박스입니다.");
		}
		return boxRepository.deleteById(boxId);
	}
}
