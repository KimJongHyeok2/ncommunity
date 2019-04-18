package com.web.ncm.board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.web.ncm.board.domain.CommentCountDTO;
import com.web.ncm.board.domain.CommentDTO;
import com.web.ncm.board.domain.RCommentDTO;
import com.web.ncm.board.domain.RReCommentDTO;
import com.web.ncm.board.domain.ReCommentDTO;
import com.web.ncm.board.service.BoardService;
import com.web.ncm.board.util.CommentValidation;
import com.web.ncm.board.util.ReCommentValidation;

@RestController
@RequestMapping("/rBoard")
public class RestBoardController {
	
	@Inject
	private BoardService boardService;

	@PostMapping("/recommend")
	@Transactional
	public String recommend(@RequestParam(value = "num", defaultValue = "0") int num,
					   @RequestParam(value = "mem_num", defaultValue = "0") int mem_num,
					   @RequestParam(value = "type", defaultValue = "0") int type,
					   String board_type) {
		if(num == 0 || mem_num == 0 || type == 0 || board_type == null || board_type.length() == 0) {
			return "Fail";
		} else {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("num", num);
			map.put("mem_num", mem_num);
			map.put("type", type);
			try {
				String checkType = boardService.selectHasRecommendHistory(map);
				if(checkType == null) {
					int count = 0;
					if(board_type.equals("freeBoard")) {						
						count = boardService.insertRecommendHistory(map);
					}
					if(count == 1) {
						int count2 = 0;
						if(board_type.equals("freeBoard")) {							
							count2 = boardService.updaetFreeBoardRecommend(map);
						}
						if(count2 == 1) {
							return String.valueOf(map.get("type"));
						} else {
							return "Fail";
						}
					}
				} else {
					if(checkType.equals("1")) {
						return "Already-Like";
					} else if(checkType.equals("2")) {
						return "Already-Hate";
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	@PostMapping("/commentRecommend")
	@Transactional
	public String commentRecommend(@RequestParam(value = "num", defaultValue = "0") int num,
			@RequestParam(value = "mem_num", defaultValue = "0") int mem_num,
			@RequestParam(value = "type", defaultValue = "0") int type,
			String comment_type) {
		if(num == 0 || mem_num == 0 || type == 0 || comment_type == null || comment_type.length() == 0) {
			return "Fail";
		} else {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("num", num);
			map.put("mem_num", mem_num);
			map.put("type", type);
			try {
				String checkType = boardService.selectHasCommentRecommendHistory(map);
				if(checkType == null) {
					int count = 0;
					if(comment_type.equals("freeComment")) {						
						count = boardService.insertCommentRecommendHistory(map);
					}
					if(count == 1) {
						int count2 = 0;
						if(comment_type.equals("freeComment")) {							
							count2 = boardService.updateFreeBoardCommentRecommend(map);
						}
						if(count2 == 1) {
							return String.valueOf(map.get("type"));
						} else {
							return "Fail";
						}
					}
				} else {
					if(checkType.equals("3")) {
						return "Already-Like";
					} else if(checkType.equals("4")) {
						return "Already-Hate";
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	@PostMapping("/insertComment")
	public String insertComment(CommentDTO dto, BindingResult result) {
		
		CommentValidation validation = new CommentValidation();
		validation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "Fail";
		}
		
		try {
			if(dto.getType().equals("freeComment")) {				
				int count = boardService.insertFreeBoardComment(dto);
				if(count == 1) {
					return "Ok";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "Fail";
	}
	
	@PostMapping("/selectComments")
	public RCommentDTO selectComments(String type, @RequestParam(value = "num", defaultValue = "0") int num) {
		
		RCommentDTO dto = new RCommentDTO();
		
		if(type == null || type.length() == 0 || num == 0) {
			return null;
		}
		
		try {
			if(type.equals("freeComments")) {				
				dto.setList(boardService.selectFreeBoardComments(num));
			} else {
				return null;
			}
			
			if(dto.getList() != null || dto.getList().size() != 0) {
				dto.setCount(dto.getList().size());
				dto.setStatus("Ok");
			} else {
				dto.setStatus("Fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@PostMapping("/insertReComment")
	public String insertReComment(ReCommentDTO dto, BindingResult result) {
		
		ReCommentValidation validation = new ReCommentValidation();
		validation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "Fail";
		}
		
		try {
			if(dto.getType().equals("freeReComment")) {				
				int count = boardService.insertFreeBoardReComment(dto);
				if(count == 1) {
					return "Ok";
				}
			} else {
				return "Fail";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "Fail";
	}
	
	@PostMapping("/selectReComments")
	public RReCommentDTO selectReComments(String type, @RequestParam(value = "num", defaultValue = "0") int num) {
		
		RReCommentDTO dto = new RReCommentDTO();
		
		if(type == null || type.length() == 0 || num == 0) {
			return null;
		}
		
		try {
			if(type.equals("freeReComments")) {				
				dto.setList(boardService.selectFreeBoardReComments(num));
			} else {
				return null;
			}
			
			if(dto.getList() != null || dto.getList().size() != 0) {
				dto.setCount(dto.getList().size());
				dto.setStatus("Ok");
		
				CommentCountDTO c_dto = new CommentCountDTO();
				c_dto.setList(boardService.selectFreeBoardCommentsCount(num));
				c_dto.setCommentsCount(c_dto.getList().size());
				dto.setCommentCount(c_dto);
			} else {
				dto.setStatus("Fail");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
	@PostMapping(value = "/updateComment", produces = "application/text; charset=utf8")
	public String updateComment(CommentDTO dto, BindingResult result) {
		
		CommentValidation validation = new CommentValidation();
		validation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "Fail";
		} else {
			try {
				if(dto.getType().equals("freeComment")) {					
					int count = boardService.updateFreeBoardComment(dto);
					if(count == 1) {
						return dto.getContent();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	@PostMapping("/deleteComment")
	public String deleteComment(String type, @RequestParam(value = "num", defaultValue = "0") int num) {

		if(type == null || type.length() == 0 || num == 0) {
			return "Fail";
		} else {
			try {
				if(type.equals("freeComment")) {					
					int count = boardService.deleteFreeBoardComment(num);
					if(count == 1) {
						return "Ok";
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	@PostMapping(value = "/updateReComment", produces = "application/text; charset=utf8")
	public String updateReComment(ReCommentDTO dto, BindingResult result) {
		
		ReCommentValidation validation = new ReCommentValidation();
		validation.validate(dto, result);
		
		if(result.hasErrors()) {
			return "Fail";
		} else {
			try {
				if(dto.getType().equals("freeComment")) {					
					int count = boardService.updateFreeBoardReComment(dto);
					if(count == 1) {
						return dto.getContent();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}
	
	@PostMapping("/deleteReComment")
	public String deleteReComment(String type, @RequestParam(value = "num", defaultValue = "0") int num) {

		if(type == null || type.length() == 0 || num == 0) {
			return "Fail";
		} else {
			try {
				if(type.equals("freeComment")) {					
					int count = boardService.deleteFreeBoardReComment(num);
					if(count == 1) {
						return "Ok";
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Fail";
	}

}
