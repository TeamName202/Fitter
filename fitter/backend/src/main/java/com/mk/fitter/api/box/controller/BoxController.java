package com.mk.fitter.api.box.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mk.fitter.api.box.repository.dto.BoxDto;
import com.mk.fitter.api.box.service.BoxService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/box")
@RequiredArgsConstructor
@Slf4j
public class BoxController {

	private final BoxService boxService;

	@GetMapping("/list")
	public ResponseEntity<List<BoxDto>> getBoxList() {
		try {
			List<BoxDto> list = boxService.getBoxList();
			return new ResponseEntity<>(list, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/create")
	public ResponseEntity<Boolean> createBox(@RequestBody BoxDto boxDto) {
		try {
			boolean result = boxService.createBox(boxDto);
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@DeleteMapping("/delete/{boxId}")
	public ResponseEntity<Boolean> deleteBox(@PathVariable int boxId) {
		try {
			boolean result = boxService.deleteBox(boxId);
			return new ResponseEntity<>(result, HttpStatus.OK);
		} catch (Exception e) {
			log.error(e.getMessage());
			return new ResponseEntity<>(false, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
