package com.web.ncm.board.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
	
	// 게시판 글 목록
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
			} else if(type.equals("freeBoard-New")) {
				dto = boardService.selectFreeBoard(page);
				pageCount = boardService.selectFreeBoardCount();
				pageCount = pageCount/row + (pageCount%row==0? 0:1);
				startPage = ((currPage-1)/pageBlock)*pageBlock+1;
				endPage = startPage + pageBlock - 1;
				
				if(endPage > pageCount) {
					endPage = pageCount;
				}
				
				pad = new PaginationDTO(pageBlock, pageCount, startPage, endPage);
			} else if(type.equals("freeBoard-Today")) {
				dto = boardService.selectFreeBoardToday();
			} else if(type.equals("freeBoard-Week")) {
				Map<String, String> map = new HashMap<String, String>();
				
				Calendar startday = Calendar.getInstance();
				startday.add(Calendar.DATE, -startday.get(Calendar.DAY_OF_WEEK)+1);
				
				Calendar endday = Calendar.getInstance();
				endday.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
				endday.add(Calendar.DATE, 7);
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				
				String startday_sdf = sdf.format(startday.getTime());
				String endday_sdf = sdf.format(endday.getTime());
				
				map.put("startday", startday_sdf);
				map.put("endday", endday_sdf);
				
				dto = boardService.selectFreeBoardWeek(map);
			} else if(type.equals("videoBoard-New")) {
				dto = boardService.selectVideoBoard(page);
				pageCount = boardService.selectVideoBoardCount();
				pageCount = pageCount/row + (pageCount%row==0? 0:1);
				startPage = ((currPage-1)/pageBlock)*pageBlock+1;
				endPage = startPage + pageBlock - 1;
				
				if(endPage > pageCount) {
					endPage = pageCount;
				}
				
				pad = new PaginationDTO(pageBlock, pageCount, startPage, endPage);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("pad", pad);
		
		return "main";
	}
	
	// 게시판 글쓰기 페이지 이동
	@GetMapping("/write")
	public String write(String type) {
		if(type == null || type.length() == 0) {
			return "redirect:/";
		}
		
		return "main";
	}
	
	// 게시판 글작성
	@PostMapping("/writeOk")
	public String writeOk(BoardDTO dto, BindingResult result) {
		BoardValidation validation = new BoardValidation();
		validation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "redirect:/board/write";
		}
		
		try {	
			if(dto.getType().equals("freeWrite")) {
				int count = boardService.insertFreeBoard(dto);
				
				if(count == 1) {
					return "redirect:/board/view?type=freeView&num=" + dto.getNum();
				}
			} else if(dto.getType().equals("videoWrite")) {
				int count = boardService.insertVideoBoard(dto);
				if(count == 1) {
					return "redirect:/board/view?type=videoView&num=" + dto.getNum();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "main";
	}
	
	// 글 상세보기
	@GetMapping("/view")
	@Transactional
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
					  if(type.equals("freeView")) {
						  boardService.updateFreeBoardViewcnt(num);
					  } else if(type.equals("videoView")) {
						  boardService.updateVideoBoardViewcnt(num);
					  }
				  }
			  }
			  
			  if(type.equals("freeView")) {				  
				  dto = boardService.selectWriteView(num);
			  } else if(type.equals("videoView")) {
				  dto = boardService.selectVideoView(num);
			  }
			  
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("dto", dto);
		
		return "main";
	}
	
	// 게시판 글수정 페이지 이동
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
	
	// 게시판 글수정
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
	
	// 게시판 글삭제
	@PostMapping("/deleteOk")
	public String deleteOk(String type, @RequestParam(value = "num", defaultValue = "0") int num) {

		if(type == null || type.length() == 0 || num == 0) {
			return "redirect:/";
		} else {
			if(type.equals("freeDelete")) {
				try {
					int count = boardService.deleteFreeBoard(num);
					
					if(count == 1) {
						return "redirect:/board?type=freeBoard-New";
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		return "main";
	}
	
}
