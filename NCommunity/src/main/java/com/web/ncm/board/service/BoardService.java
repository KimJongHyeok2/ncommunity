package com.web.ncm.board.service;

import java.util.List;
import java.util.Map;

import com.web.ncm.board.domain.BoardDTO;

public interface BoardService {
	public int insertFreeBoard(BoardDTO dto) throws Exception;
	public List<BoardDTO> selectFreeBoard(Map<String, Integer> page) throws Exception;
	public int selectFreeBoardCount() throws Exception;
	public BoardDTO selectWriteView(int num) throws Exception;
	public int updateViewcnt(int num) throws Exception;
	public int updateFreeBoard(BoardDTO dto) throws Exception;
	public int deleteFreeBoard(int num) throws Exception;
	public String selectHasRecommendHistory(Map<String, Integer> map) throws Exception;
	public int insertRecommendHistory(Map<String, Integer> map) throws Exception;
	public int updaetBoardRecommend(Map<String, Integer> map) throws Exception;
}