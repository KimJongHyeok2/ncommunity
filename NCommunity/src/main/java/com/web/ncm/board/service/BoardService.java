package com.web.ncm.board.service;

import com.web.ncm.board.domain.BoardDTO;

public interface BoardService {
	public int insertFreeBoard(BoardDTO dto) throws Exception;
}
