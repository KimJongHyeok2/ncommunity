package com.web.ncm.board.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/upload")
public class RestUploadController {

	@RequestMapping("/img")
	public String img() {
		System.out.println("여기옴");
		
		return "Ok";
	}
}
