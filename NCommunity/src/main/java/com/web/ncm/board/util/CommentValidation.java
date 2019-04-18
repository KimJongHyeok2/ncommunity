package com.web.ncm.board.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.ncm.board.domain.CommentDTO;

public class CommentValidation implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return CommentDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		CommentDTO dto = (CommentDTO)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "type", "emptyCommentType");
		
		if(dto.getType().equals("freeComment")) {
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "num", "emptyCommentNumber");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "emptyCommentContent");
		} else {
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "board_num", "emptyBoardNumber");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_num", "emptyMemberNumber");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "emptyCommentContent");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "type", "emptyCommentType");			
		}
	
	}

}
