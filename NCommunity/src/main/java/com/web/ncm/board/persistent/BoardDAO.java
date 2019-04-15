package com.web.ncm.board.persistent;

import java.util.List;
import java.util.Map;

import com.web.ncm.board.domain.BoardDTO;

public interface BoardDAO {
	public int insertFreeBoard(BoardDTO dto) throws Exception;
	public List<BoardDTO> selectFreeBoard(Map<String, Integer> page) throws Exception;
	public int selectFreeBoardCount() throws Exception;
}