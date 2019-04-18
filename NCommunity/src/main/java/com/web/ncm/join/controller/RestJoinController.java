package com.web.ncm.join.controller;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.web.ncm.join.domain.EmailAccessDTO;
import com.web.ncm.join.domain.JoinDTO;
import com.web.ncm.join.service.JoinService;
import com.web.ncm.join.util.EmailValidation;
import com.web.ncm.join.util.JoinValidation;

@RestController
@RequestMapping("/join")
public class RestJoinController {
	
	@Inject
	private JavaMailSender mailSender;
	@Inject
	private JoinService joinService;
	
	// 아이디 중복확인
	@PostMapping("/idOverlap")
	public String idOverlap(String id) {
		boolean idFlag = false;
		
		if(id == null || id.length() == 0) {
			return "Invalid";
		}
		
		try {
			int count = joinService.checkOverlapID(id);
			
			if(count == 0) {
				idFlag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(!idFlag) {
			return "Fail";
		}
		return "Ok";
	}
	
	// 이메일 인증키 전송
	@PostMapping("/sendEmail")
	public int mailSend(String email) {
		if(email == null || email.length() == 0) {
			return 0;
		}
		
		EmailAccessDTO accessDto = new EmailAccessDTO();
		
		MimeMessage mail = mailSender.createMimeMessage();
		String html = "<h3>아래 인증키를 입력해주세요.</h3>"
					+ "<div style='width: 200px; height: 50px; line-height: 50px; text-align: center; background-color: rgba(246, 246, 246, 0.4); border: 1px solid #D5D5D5;'>"
					+ accessDto.getEkey_accesskey()
					+ "</div>";
		
		try {
			mail.setText(html, "utf-8", "html");
			mail.setSubject("[NCommunity] 가입을 위한 이메일 인증키입니다.");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
			joinService.insertEKey(accessDto);
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return accessDto.getEkey_num();
	}
	
	// 이메일 인증키 확인
	@PostMapping("/emailAccess")
	public String emailAccess(EmailAccessDTO dto, BindingResult result) {
		// 이메일 인증 전 유효성 검사
		EmailValidation vaildation = new EmailValidation();
		vaildation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "Invalid";
		}
		
		boolean keyFlag = false;
		
		try {
			// DB에 저장된 인증키 불러오기
			String db_accessKey = joinService.selectEKey(dto.getEkey_num());
			
			if(db_accessKey.equals(dto.getEkey_accesskey())) {
				keyFlag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		if(!keyFlag) {
			return "Fail";
		}
		
		return "Ok";
	}
	
	// 회원가입
	@PostMapping("/joinOk")
	public String joinOk(JoinDTO dto, BindingResult result) {
		// 가입 전 유효성 검사
		JoinValidation vaildation = new JoinValidation();
		vaildation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "Invalid";
		}
		
		boolean joinFlag = false;
		
		try {
			int count = joinService.insertMember(dto);
			
			if(count == 1) {
				joinFlag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(!joinFlag) {
			return "Fail";
		}
		
		return "Ok";
	}
	
}