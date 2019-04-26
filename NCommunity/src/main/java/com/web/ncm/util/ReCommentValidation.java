package com.web.ncm.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.ncm.domain.ReCommentDTO;

public class ReCommentValidation implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return ReCommentDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		ReCommentDTO dto = (ReCommentDTO)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "type", "emptyReCommentType");
		
		if(dto.getType().equals("freeComment")) {
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "num", "emptyCommentNumber");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "emptyCommentContent");
		} else {
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "comment_num", "emptyCommentNumber");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "board_num", "emptyBoardNumber");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_num", "emptyMemberNumber");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "type", "emptyReCommentType");			
		}
	}

}
