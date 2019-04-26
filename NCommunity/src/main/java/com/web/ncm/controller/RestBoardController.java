package com.web.ncm.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.web.ncm.domain.CommentCountDTO;
import com.web.ncm.domain.CommentDTO;
import com.web.ncm.domain.RCommentDTO;
import com.web.ncm.domain.RReCommentDTO;
import com.web.ncm.domain.ReCommentDTO;
import com.web.ncm.service.BoardService;
import com.web.ncm.util.CommentValidation;
import com.web.ncm.util.ReCommentValidation;

@RestController
@RequestMapping("/rBoard")
public class RestBoardController {
	
	@Inject
	private BoardService boardService;

	// 게시물 좋아요/싫어요
	@PostMapping("/recommend")
	@Transactional
	public String recommend(@RequestParam(value = "num", defaultValue = "0") int num,
					   @RequestParam(value = "mem_num", defaultValue = "0") int mem_num,
					   @RequestParam(value = "recommendtype", defaultValue = "0") int recommendtype,
					   String board_type) {
		if(num == 0 || mem_num == 0 || recommendtype == 0 || board_type == null || board_type.length() == 0) {
			return "Fail";
		} else {
			Map<String, String> map = new HashMap<String, String>();
			map.put("num", String.valueOf(num));
			map.put("mem_num", String.valueOf(mem_num));
			map.put("recommendtype", String.valueOf(recommendtype));
			map.put("boardtype", board_type);
			try {
				// 해당 게시물이 추천을 누른 기록이 있는지 확인
				String checkType = boardService.selectHasRecommendHistory(map);
				if(checkType == null) {
					int count = 0;
					count = boardService.insertRecommendHistory(map);

					if(count == 1) {
						int count2 = 0;
						if(board_type.equals("freeBoard")) {							
							count2 = boardService.updaetFreeBoardRecommend(map);
						} else if(board_type.equals("videoBoard")) {
							count2 = boardService.updateVideoBoardRecommend(map);
						}
						
						if(count2 == 1) {
							return String.valueOf(map.get("recommendtype"));
						} else {
							return "Fail";
						}
					}
				} else { // 이미 눌렀다면
					// 좋아요를 눌렀는지 싫어요를 눌렀는지 반환 
					if(checkType.equals("1") || checkType.equals("5")) { 
						return "Already-Like";
					} else if(checkType.equals("2") || checkType.equals("6")) {
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
			@RequestParam(value = "recommendtype", defaultValue = "0") int recommendtype,
			String comment_type) {
		if(num == 0 || mem_num == 0 || recommendtype == 0 || comment_type == null || comment_type.length() == 0) {
			return "Fail";
		} else {
			Map<String, String> map = new HashMap<String, String>();
			map.put("num", String.valueOf(num));
			map.put("mem_num", String.valueOf(mem_num));
			map.put("recommendtype", String.valueOf(recommendtype));
			map.put("boardtype", comment_type);
			try {
				String checkType = boardService.selectHasCommentRecommendHistory(map);
				if(checkType == null) {
					int count = 0;
					count = boardService.insertCommentRecommendHistory(map);
					
					if(count == 1) {
						int count2 = 0;
						if(comment_type.equals("freeComment")) {							
							count2 = boardService.updateFreeBoardCommentRecommend(map);
						} else if(comment_type.equals("videoComment")) {
							count2 = boardService.updateVideoBoardCommentRecommend(map);
						}
						
						if(count2 == 1) {
							return String.valueOf(map.get("recommendtype"));
						} else {
							return "Fail";
						}
					}
				} else {
					if(checkType.equals("3") || checkType.equals("7")) {
						return "Already-Like";
					} else if(checkType.equals("4") || checkType.equals("8")) {
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
			} else if(dto.getType().equals("videoComment")) {
				int count = boardService.insertVideoBoardComment(dto);
				
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
	public RCommentDTO selectComments(String type, String list_type, @RequestParam(value = "num", defaultValue = "0") int num) {
		
		RCommentDTO dto = new RCommentDTO();
		
		if(type == null || type.length() == 0 || num == 0) {
			return null;
		}
		
		if(list_type == null || list_type.length() == 0) {
			list_type = "new";
		}
		
		try {
			if(type.equals("freeComments")) {		
				if(list_type.equals("popular")) {
					dto.setList(boardService.selectFreeBoardComments_popular(num));
				} else {
					dto.setList(boardService.selectFreeBoardComments(num));
				}
			} else if(type.equals("videoComments")) {
				if(list_type.equals("popular")) {
					dto.setList(boardService.selectVideoBoardComments_popular(num));
				} else {
					dto.setList(boardService.selectVideoBoardComments(num));
				}
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
			} else if(dto.getType().equals("videoReComment")) {
				int count = boardService.insertVideoBoardReComment(dto);
				
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
			} else if(type.equals("videoReComments")) {
				dto.setList(boardService.selectVideoBoardReComments(num));
			} else {
				return null;
			}
			
			if(dto.getList() != null || dto.getList().size() != 0) {
				dto.setCount(dto.getList().size());
				dto.setStatus("Ok");
		
				CommentCountDTO c_dto = new CommentCountDTO();
				if(type.equals("freeReComments")) {
					c_dto.setList(boardService.selectFreeBoardCommentsCount(num));
				} else if(type.equals("videoReComments")) {
					c_dto.setList(boardService.selectVideoBoardCommentsCount(num));	
				}
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
				} else if(dto.getType().equals("videoComment")) {
					int count = boardService.updateVideoBoardComment(dto);
					
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
						int count2 = boardService.deleteFreeBoardReComments(num);
						
						if(count2 >= 1) {							
							return "Ok";
						}
					}
				} else if(type.equals("videoComment")) {
					int count = boardService.deleteVideoBoardComment(num);
					
					if(count == 1) {
						int count2 = boardService.deleteVideoBoardReComments(num);
						
						if(count2 >= 1) {							
							return "Ok";
						}
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
				} else if(dto.getType().equals("videoComment")) {
					int count = boardService.updateVideoBoardReComment(dto);
					
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
				} else if(type.equals("videoComment")) {
					int count = boardService.deleteVideoBoardReComment(num);
					
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
