package com.web.ncm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/join")
public class JoinController {
	
	// 회원가입 페이지 이동
	@GetMapping("")
	public String join() {
		return "join/join";
	}
	
}