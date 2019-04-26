package com.web.ncm.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.ncm.domain.MemberDTO;
import com.web.ncm.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Inject
	MemberService memberService;
	
	@GetMapping("/modify")
	public String modify(String type, HttpServletRequest request, Model model) {
		
		int num = 0;
		
		if(request.getSession().getAttribute("num") != null) {
			num = (Integer)request.getSession().getAttribute("num");
		}
		
		if(num == 0) {
			return "redirect:/";
		}
		
		try {
			MemberDTO dto = memberService.selectMemberInfo(num);
			
			if(dto != null) {
				model.addAttribute("dto", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "main";
	}
	
}