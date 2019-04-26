package com.web.ncm.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.ncm.domain.JoinDTO;

public class JoinValidation implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return JoinDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		JoinDTO dto = (JoinDTO)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_id", "emptyID");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_pw", "emptyPW");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_birth", "emptyBirth");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_email", "emptyEmail");
	}

}