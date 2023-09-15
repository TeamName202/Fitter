package com.mk.fitter.api.box.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.box.repository.dto.BoxDto;
import com.mk.fitter.api.box.service.BoxService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/box")
@RequiredArgsConstructor
public class BoxController {

	private final BoxService boxService;

	@GetMapping("/list")
	public ResponseEntity<List<BoxDto>> getBoxList() {
		try {
			List<BoxDto> list = boxService.getBoxList();
			return new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
