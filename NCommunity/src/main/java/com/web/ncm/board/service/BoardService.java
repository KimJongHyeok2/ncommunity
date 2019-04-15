package com.web.ncm.board.service;

import java.util.List;
import java.util.Map;

import com.web.ncm.board.domain.BoardDTO;

public interface BoardService {
	public int insertFreeBoard(BoardDTO dto) throws Exception;
	public List<BoardDTO> selectFreeBoard(Map<String, Integer> page) throws Exception;
	public int selectFreeBoardCount() throws Exception;
	public BoardDTO selectWriteView(int num) throws Exception;
}
