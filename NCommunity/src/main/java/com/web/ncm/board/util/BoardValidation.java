package com.web.ncm.board.util;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.web.ncm.board.domain.BoardDTO;

public class BoardValidation implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return BoardDTO.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		BoardDTO dto = (BoardDTO)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mem_num", "emptyMemberNumber");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "type", "emptyBoardType");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "subject", "emptySubject");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "emptyContent");
		
		if(dto.getType().equals("videoWrite")) {
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "thumb", "emptyVideoThumbnail");
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "description", "emptyDescription");
		}
	}

}
