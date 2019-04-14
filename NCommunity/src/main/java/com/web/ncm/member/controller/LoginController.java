package com.web.ncm.member.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.ncm.member.domain.MemberDTO;
import com.web.ncm.member.service.MemberService;
import com.web.ncm.member.util.LoginValidation;

@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Inject
	private MemberService memberService;
	
	// 로그인 페이지 이동
	@GetMapping("")
	public String login() {
		return "login/login";
	}
	
	// 로그인 요청
	@PostMapping("/loginOk")
	public String loginOk(MemberDTO dto, BindingResult result) {
		LoginValidation validation = new LoginValidation();
		validation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "redirect:/login";
		}
		
		try {
			dto = memberService.selectMember(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(dto == null) {
			return "redirect:/login?result=fail";
		} else {
			// 정지된 계정
			if(dto.getEnabled() == 5) {
				return "redirect:/login?result=blocked";				
			}
		}
		
		return "main";
	}
	
}