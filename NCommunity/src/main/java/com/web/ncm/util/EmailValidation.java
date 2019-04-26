package com.web.ncm.util;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.web.ncm.domain.EmailAccessDTO;

public class EmailValidation implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return EmailAccessDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		EmailAccessDTO dto = (EmailAccessDTO)target;
		
		if(dto.getEkey_num() == 0) {
			errors.reject("ekey_num", "invalid");
		}
		if(dto.getEkey_accesskey() == null || dto.getEkey_accesskey().length() == 0) {
			errors.reject("ekey_accesskey", "invalid");
		}
		
	}

}
