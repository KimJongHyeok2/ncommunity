package com.web.ncm.board.service;

import java.util.List;
import java.util.Map;

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

	@Override
	public List<BoardDTO> selectFreeBoard(Map<String, Integer> page) throws Exception {
		return dao.selectFreeBoard(page);
	}

	@Override
	public int selectFreeBoardCount() throws Exception {
		return dao.selectFreeBoardCount();
	}

	@Override
	public BoardDTO selectWriteView(int num) throws Exception {
		return dao.selectWriteView(num);
	}
	
}
