package com.web.ncm.board.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.web.ncm.board.domain.BoardDTO;
import com.web.ncm.board.service.BoardService;
import com.web.ncm.board.util.BoardValidation;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Inject
	private BoardService boardService;
	
	@GetMapping("")
	public String board(String type) {
		
		if(type == null || type.length() == 0) {
			return "redirect:/";
		}
		
		return "";
	}
	
	@GetMapping("/write")
	public String write(String type) {
		
		if(type == null || type.length() == 0) {
			return "redirect:/";
		}		
		
		return "";
	}
	
	@PostMapping("/writeOk")
	public String writeOk(BoardDTO dto, BindingResult result) {
		
		BoardValidation validation = new BoardValidation();
		validation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "redirect:/board/write";
		}

		if(dto.getType().equals("free")) {
			try {
				boardService.insertFreeBoard(dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "/";
	}
	
}
