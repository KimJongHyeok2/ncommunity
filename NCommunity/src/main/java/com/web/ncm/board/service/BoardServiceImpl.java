package com.web.ncm.board.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.ncm.board.domain.BoardDTO;
import com.web.ncm.board.domain.CommentDTO;
import com.web.ncm.board.domain.ReCommentDTO;
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

	@Override
	public int updateViewcnt(int num) throws Exception {
		return dao.updateViewcnt(num);
	}

	@Override
	public int updateFreeBoard(BoardDTO dto) throws Exception {
		return dao.updateFreeBoard(dto);
	}

	@Override
	public int deleteFreeBoard(int num) throws Exception {
		return dao.deleteFreeBoard(num);
	}

	@Override
	public String selectHasRecommendHistory(Map<String, Integer> map) throws Exception {
		return dao.selectHasRecommendHistory(map);
	}

	@Override
	public int insertRecommendHistory(Map<String, Integer> map) throws Exception {
		return dao.insertRecommendHistory(map);
	}

	@Override
	public int updaetBoardRecommend(Map<String, Integer> map) throws Exception {
		return dao.updateBoardRecommend(map);
	}

	@Override
	public int insertFreeBoardComment(CommentDTO dto) throws Exception {
		return dao.insertFreeBoardComment(dto);
	}

	@Override
	public List<CommentDTO> selectFreeBoardComments(int num) throws Exception {
		return dao.selectFreeBoardComments(num);
	}

	@Override
	public int insertFreeBoardReComment(ReCommentDTO dto) throws Exception {
		return dao.insertFreeBoardReComment(dto);
	}

	@Override
	public List<ReCommentDTO> selectFreeBoardReComments(int num) throws Exception {
		return dao.selectFreeBoardReComments(num);
	}

	@Override
	public List<CommentDTO> selectFreeBoardCommentsCount(int num) throws Exception {
		return dao.selectFreeBoardCommentsCount(num);
	}
	
}
