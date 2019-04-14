package com.web.ncm.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
	
/*	private static final Logger logger = LoggerFactory.getLogger(MainController.class);*/
	
	// 메인페이지 이동
	@GetMapping("/")
	public String main() {
		return "main";
	}

}