package com.web.ncm.member.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.ncm.member.domain.MemberDTO;

public class LoginValidation implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberDTO dto = (MemberDTO)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_id", "emptyID");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_pw", "emptyPW");
	}

}
