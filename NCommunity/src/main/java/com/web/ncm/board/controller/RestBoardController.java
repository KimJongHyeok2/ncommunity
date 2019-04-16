package com.web.ncm.board.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.web.ncm.board.service.BoardService;

@RestController
@RequestMapping("/rBoard")
public class RestBoardController {
	
	private BoardService boardService;
	
	@Inject
	public void setBoardService(BoardService boardService) {
		System.out.println("생성");
		this.boardService = boardService;
	}



	@RequestMapping("/recommend")
	@Transactional
	public String like(@RequestParam(value = "num", defaultValue = "0") int num,
					   @RequestParam(value = "mem_num", defaultValue = "0") int mem_num,
					   @RequestParam(value = "type", defaultValue = "0") int type) {
		if(num == 0 || mem_num == 0 || type == 0) {
			return "Fail";
		} else {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("num", num);
			map.put("mem_num", mem_num);
			map.put("type", type);
			try {
				String checkType = boardService.selectHasRecommendHistory(map);
				if(checkType == null) {
					int count = boardService.insertRecommendHistory(map);
					if(count == 1) {
						int count2 = boardService.updaetBoardRecommend(map);
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
	
}
