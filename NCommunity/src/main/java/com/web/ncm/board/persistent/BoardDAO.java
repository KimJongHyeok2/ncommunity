package com.web.ncm.board.persistent;

import java.util.List;
import java.util.Map;

import com.web.ncm.board.domain.BoardDTO;

public interface BoardDAO {
	public int insertFreeBoard(BoardDTO dto) throws Exception;
	public List<BoardDTO> selectFreeBoard(Map<String, Integer> page) throws Exception;
	public int selectFreeBoardCount() throws Exception;
	public BoardDTO selectWriteView(int num) throws Exception;
	public int updateViewcnt(int num) throws Exception;
	public int updateFreeBoard(BoardDTO dto) throws Exception;
	public int deleteFreeBoard(int num) throws Exception;
	public String selectHasRecommendHistory(Map<String, Integer> map) throws Exception;
	public int insertRecommendHistory(Map<String, Integer> map) throws Exception;
	public int updateBoardRecommend(Map<String, Integer> map) throws Exception;
}