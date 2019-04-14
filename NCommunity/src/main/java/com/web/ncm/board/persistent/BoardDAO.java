package com.web.ncm.board.persistent;

import com.web.ncm.board.domain.BoardDTO;

public interface BoardDAO {
	public int insertFreeBoard(BoardDTO dto) throws Exception;
}