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
	public int updateFreeBoardViewcnt(int num) throws Exception {
		return dao.updateFreeBoardViewcnt(num);
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
	public String selectHasRecommendHistory(Map<String, String> map) throws Exception {
		return dao.selectHasRecommendHistory(map);
	}

	@Override
	public int insertRecommendHistory(Map<String, String> map) throws Exception {
		return dao.insertRecommendHistory(map);
	}

	@Override
	public int updaetFreeBoardRecommend(Map<String, String> map) throws Exception {
		return dao.updateFreeBoardRecommend(map);
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
	public List<CommentDTO> selectFreeBoardComments_popular(int num) throws Exception {
		return dao.selectFreeBoardComments_popular(num);
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

	@Override
	public int updateFreeBoardComment(CommentDTO dto) throws Exception {
		return dao.updateFreeBoardComment(dto);
	}

	@Override
	public int deleteFreeBoardComment(int num) throws Exception {
		return dao.deleteFreeBoardComment(num);
	}

	@Override
	public int updateFreeBoardReComment(ReCommentDTO dto) throws Exception {
		return dao.updateFreeBoardReComment(dto);
	}

	@Override
	public int deleteFreeBoardReComment(int num) throws Exception {
		return dao.deleteFreeBoardReComment(num);
	}

	@Override
	public String selectHasCommentRecommendHistory(Map<String, String> map) throws Exception {
		return dao.selectHasCommentRecommendHistory(map);
	}

	@Override
	public int insertCommentRecommendHistory(Map<String, String> map) throws Exception {
		return dao.insertCommentRecommendHistory(map);
	}

	@Override
	public int updateFreeBoardCommentRecommend(Map<String, String> map) throws Exception {
		return dao.updateFreeBoardCommentRecommend(map);
	}

	@Override
	public List<BoardDTO> selectFreeBoardWeek(Map<String, String> map) throws Exception {
		return dao.selectFreeBoardWeek(map);
	}

	@Override
	public List<BoardDTO> selectFreeBoardToday() throws Exception {
		return dao.selectFreeBoardToday();
	}

	@Override
	public int insertVideoBoard(BoardDTO dto) throws Exception {
		return dao.insertVideoBoard(dto);
	}

	@Override
	public BoardDTO selectVideoView(int num) throws Exception {
		return dao.selectVideoView(num);
	}

	@Override
	public int updateVideoBoardViewcnt(int num) throws Exception {
		return dao.updateVideoBoardViewcnt(num);
	}

	@Override
	public List<BoardDTO> selectVideoBoard(Map<String, Integer> page) throws Exception {
		return dao.selectVideoBoard(page);
	}

	@Override
	public int selectVideoBoardCount() throws Exception {
		return dao.selectVideoBoardCount();
	}

	@Override
	public int updateVideoBoard(BoardDTO dto) throws Exception {
		return dao.updateVideoBoard(dto);
	}

	@Override
	public int deleteVideoBoard(int num) throws Exception {
		return dao.deleteVideoBoard(num);
	}

	@Override
	public int updateVideoBoardRecommend(Map<String, String> map) throws Exception {
		return dao.updateVideoBoardRecommend(map);
	}

	@Override
	public int insertVideoBoardComment(CommentDTO dto) throws Exception {
		return dao.insertVideoBoardComment(dto);
	}

	@Override
	public List<CommentDTO> selectVideoBoardComments(int num) throws Exception {
		return dao.selectVideoBoardComments(num);
	}

	@Override
	public List<CommentDTO> selectVideoBoardComments_popular(int num) throws Exception {
		return dao.selectVideoBoardComments_popular(num);
	}

	@Override
	public int insertVideoBoardReComment(ReCommentDTO dto) throws Exception {
		return dao.insertVideoBoardReComment(dto);
	}

	@Override
	public List<ReCommentDTO> selectVideoBoardReComments(int num) throws Exception {
		return dao.selectVideoBoardReComments(num);
	}

	@Override
	public List<CommentDTO> selectVideoBoardCommentsCount(int num) throws Exception {
		return dao.selectVideoBoardCommentsCount(num);
	}

	@Override
	public int updateVideoBoardCommentRecommend(Map<String, String> map) throws Exception {
		return dao.updateVideoBoardCommentRecommend(map);
	}

	@Override
	public int updateVideoBoardComment(CommentDTO dto) throws Exception {
		return dao.updateVideoBoardComment(dto);
	}

	@Override
	public int updateVideoBoardReComment(ReCommentDTO dto) throws Exception {
		return dao.updateVideoBoardReComment(dto);
	}

	@Override
	public int deleteVideoBoardComment(int num) throws Exception {
		return dao.deleteVideoBoardComment(num);
	}
	
	@Override
	public int deleteVideoBoardReComment(int num) throws Exception {
		return dao.deleteVideoBoardReComment(num);
	}
	
	@Override
	public int deleteFreeBoardReComments(int num) throws Exception {
		return dao.deleteFreeBoardReComments(num);
	}

	@Override
	public int deleteVideoBoardReComments(int num) throws Exception {
		return dao.deleteVideoBoardReComments(num);
	}

	@Override
	public List<BoardDTO> selectVideoBoardToday() throws Exception {
		return dao.selectVideoBoardToday();
	}

	@Override
	public List<BoardDTO> selectVideoBoardWeek(Map<String, String> map) throws Exception {
		return dao.selectVideoBoardWeek(map);
	}
	
}
