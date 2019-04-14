package com.web.ncm.board.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.ncm.board.domain.BoardDTO;
import com.web.ncm.board.persistent.BoardDAO;

@Service("BoardService")
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
	
	@Override
	public int insertFreeBoard(BoardDTO dto) throws Exception {
		return dao.insertFreeBoard(dto);
	}

}
