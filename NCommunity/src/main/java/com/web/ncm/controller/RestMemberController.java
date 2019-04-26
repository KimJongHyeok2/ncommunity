package com.web.ncm.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.web.ncm.service.MemberService;

@RestController
@RequestMapping("/rMember")
public class RestMemberController {
	
	@Inject
	MemberService memberService;

	@PostMapping(value = "/profile", produces = "application/text; charset=utf-8")
	public String profile(HttpServletRequest request, String testVal) {
		
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/profile");
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		
		File dir = new File(saveDirectory);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
	
		
		MultipartRequest multi;
		try {
			multi = new MultipartRequest(request, saveDirectory, 10 * 1024 * 1024, "UTF-8", policy);
			
			Enumeration<String> enums = multi.getFileNames();
			
			int mem_num = 0;
			
			if(multi.getParameter("mem_num") != null) {
				mem_num = Integer.parseInt(multi.getParameter("mem_num"));
			}
			
			if(mem_num == 0) {
				return "Fail";
			}
			
			while(enums.hasMoreElements()) {
				String name = enums.nextElement();
				String value = multi.getFilesystemName(name);

				Map<String, String> map = new HashMap<String, String>();
				
				map.put("profile", value);
				map.put("mem_num", String.valueOf(mem_num));
				
				try {
					int count = memberService.updateMemberProfile(map);
					
					if(count == 1) {
						return value;		
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return "Fail";
	}
	
	@PostMapping(value = "/nickname", produces = "application/text; charset=utf-8")
	public String nickname(@RequestParam(value = "mem_num", defaultValue = "0") int mem_num, String nickname, HttpServletRequest request) {
		
		if(mem_num == 0 || nickname == null || nickname == "" || nickname.length() == 0) {
			return "Fail";
		} else {
			Map<String, String> map = new HashMap<String, String>();
			map.put("nickname", nickname);
			map.put("mem_num", String.valueOf(mem_num));
			
			try {
				int count = memberService.updateMemberNickname(map);
				
				if(count == 1) {
					request.getSession().setAttribute("nickname", nickname);
					return nickname;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
}
