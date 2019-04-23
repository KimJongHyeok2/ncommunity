package com.web.ncm.main.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.web.ncm.board.domain.BoardDTO;
import com.web.ncm.board.domain.PaginationDTO;
import com.web.ncm.board.service.BoardService;

@Controller
public class MainController {
	
	@Inject
	BoardService boardService;
	
/*	private static final Logger logger = LoggerFactory.getLogger(MainController.class);*/
	
	// 메인페이지 이동
	@GetMapping("/")
	public String main(Model model) {
		
		List<BoardDTO> dto = null;
		// 한 페이지에 출력할 게시글 수
		int row = 10;
		// 현재 페이지
		int currPage = 1;
		// 한 페이지 당 페이징 블럭 수
		int pageBlock = 10;
		// 총 페이지 수
		int pageCount = 0;
		// 시작 페이지
		int startPage = 0;
		// 끝 페이지
		int endPage = 0;
		
		Map<String, Integer> page = new HashMap<String, Integer>();
		page.put("page", (currPage-1)*row+1);
		page.put("row", row);
		
		try {
			// 자유게시판 최신글
			dto = boardService.selectFreeBoard(page);
			pageCount = boardService.selectFreeBoardCount();
			pageCount = pageCount/row + (pageCount%row==0? 0:1);
			startPage = ((currPage-1)/pageBlock)*pageBlock+1;
			endPage = startPage + pageBlock - 1;
				
			if(endPage > pageCount) {
				endPage = pageCount;
			}
			
			model.addAttribute("board_new", dto);
			
			// 자유게시판 오늘의 인기글
			dto = boardService.selectFreeBoardToday();
			model.addAttribute("board_today", dto);
			
			dto = boardService.selectVideoBoard(page);
			pageCount = boardService.selectVideoBoardCount();
			pageCount = pageCount/row + (pageCount%row==0? 0:1);
			startPage = ((currPage-1)/pageBlock)*pageBlock+1;
			endPage = startPage + pageBlock - 1;
				
			if(endPage > pageCount) {
				endPage = pageCount;
			}
			
			dto = boardService.selectVideoBoardToday();
			model.addAttribute("board_video_today", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "main";
	}

}