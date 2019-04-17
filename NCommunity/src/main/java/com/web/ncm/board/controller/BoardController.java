package com.web.ncm.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.web.ncm.board.domain.BoardDTO;
import com.web.ncm.board.domain.PaginationDTO;
import com.web.ncm.board.service.BoardService;
import com.web.ncm.board.util.BoardValidation;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Inject
	private BoardService boardService;
	
	@GetMapping("")
	public String board(String type, @RequestParam(value = "currPage", defaultValue = "1") int currPage, Model model) {
		List<BoardDTO> dto = null;
		PaginationDTO pad = null;
		// 한 페이지에 출력할 게시글 수
		int row = 10;
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
			if(type == null || type.length() == 0) {
				return "redirect:/";
			} else if(type.equals("freeBoard")) {
				dto = boardService.selectFreeBoard(page);
				pageCount = boardService.selectFreeBoardCount();
				pageCount = pageCount/row + (pageCount%row==0? 0:1);
				startPage = ((currPage-1)/pageBlock)*pageBlock+1;
				endPage = startPage + pageBlock - 1;
				
				if(endPage > pageCount) {
					endPage = pageCount;
				}
				
				pad = new PaginationDTO(pageBlock, pageCount, startPage, endPage);
			} else if(type.equals("videoBoard")) {
				System.out.println("동영상 게시판");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("pad", pad);
		
		return "main";
	}
	
	@GetMapping("/write")
	public String write(String type) {
		if(type == null || type.length() == 0) {
			return "redirect:/";
		}
		
		return "main";
	}
	
	@PostMapping("/writeOk")
	public String writeOk(BoardDTO dto, BindingResult result) {
		BoardValidation validation = new BoardValidation();
		validation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "redirect:/board/write";
		}

		if(dto.getType().equals("freeWrite")) {
			try {
				int count = boardService.insertFreeBoard(dto);
				
				if(count == 1) {
					return "redirect:/board/view?type=freeView&num=" + dto.getNum();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "main";
	}
	
	@GetMapping("/view")
	public String view(String type, @RequestParam(value = "num", defaultValue = "0") int num,
						HttpServletRequest request, HttpServletResponse response, Model model) {
		if(type == null || type.length() == 0 || num == 0) {
			return "redirect:/";
		}
		
		BoardDTO dto = null;
		
		try {
			  Cookie[] cookie = request.getCookies();
			  
			  if(cookie != null) {			  
				  boolean viewCookieFlag = false;
				  
				  for(int i=0; i<cookie.length; i++) {
					  if(cookie[i].getName().equals("view" + num)) {
						  viewCookieFlag = true;
					  }
				  }
				  
				  if(!viewCookieFlag) {	  
					  Cookie viewCookie = new Cookie("view" + num, String.valueOf(num));
					  viewCookie.setMaxAge(21600);
					  response.addCookie(viewCookie);
					  boardService.updateViewcnt(num);
				  }
			  }
			  
			  dto = boardService.selectWriteView(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("dto", dto);
		
		return "main";
	}
	
	@GetMapping("/update")
	public String update(String type, @RequestParam(value = "num", defaultValue = "0") int num, Model model) {
		if(type == null || type.length() == 0 || num == 0) {
			return "redirect:/";
		}
		
		BoardDTO dto = null;
		
		try {
			dto = boardService.selectWriteView(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("dto", dto);
		
		return "main";
	}
	
	@PostMapping("/updateOk")
	public String updateOk(BoardDTO dto, BindingResult result) {
		BoardValidation validation = new BoardValidation();
		validation.validate(dto, result);		
		
		if(result.hasErrors()) {
			return "redirect:/";
		}
		
		if(dto.getType().equals("freeUpdate")) {
			try {
				int count = boardService.updateFreeBoard(dto);
				
				if(count == 1) {
					return "redirect:/board/view?type=freeView&num=" + dto.getNum();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "main";
	}
	
	@PostMapping("/deleteOk")
	public String deleteOk(String type, @RequestParam(value = "num", defaultValue = "0") int num) {

		if(type == null || type.length() == 0 || num == 0) {
			return "redirect:/";
		} else {
			if(type.equals("freeDelete")) {
				try {
					int count = boardService.deleteFreeBoard(num);
					
					if(count == 1) {
						return "redirect:/board?type=freeBoard";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return "main";
	}
	
}
