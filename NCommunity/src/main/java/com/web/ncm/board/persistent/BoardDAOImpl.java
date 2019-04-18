package com.web.ncm.board.persistent;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.ncm.board.domain.BoardDTO;
import com.web.ncm.board.domain.CommentDTO;
import com.web.ncm.board.domain.ReCommentDTO;

@Repository("BoardDAO")
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int insertFreeBoard(BoardDTO dto) throws Exception {
		return sqlSession.insert("board.insertFreeBoard", dto);
	}

	@Override
	public List<BoardDTO> selectFreeBoard(Map<String, Integer> page) throws Exception {
		return sqlSession.selectList("board.selectFreeBoard", page);
	}

	@Override
	public int selectFreeBoardCount() throws Exception {
		return sqlSession.selectOne("board.selectFreeBoardCount");
	}

	@Override
	public BoardDTO selectWriteView(int num) throws Exception {
		return sqlSession.selectOne("board.selectWriteView", num);
	}

	@Override
	public int updateViewcnt(int num) throws Exception {
		return sqlSession.update("board.updateViewcnt", num);
	}

	@Override
	public int updateFreeBoard(BoardDTO dto) throws Exception {
		return sqlSession.update("board.updateFreeBoard", dto);
	}

	@Override
	public int deleteFreeBoard(int num) throws Exception {
		return sqlSession.delete("board.deleteFreeBoard", num);
	}

	@Override
	public String selectHasRecommendHistory(Map<String, Integer> map) throws Exception {
		return sqlSession.selectOne("board.selectHasRecommendHistory", map);
	}

	@Override
	public int insertRecommendHistory(Map<String, Integer> map) throws Exception {
		return sqlSession.insert("board.insertRecommendHistory", map);
	}

	@Override
	public int updateFreeBoardRecommend(Map<String, Integer> map) throws Exception {
		return sqlSession.update("board.updateFreeBoardRecommend", map);
	}

	@Override
	public int insertFreeBoardComment(CommentDTO dto) throws Exception {
		return sqlSession.insert("board.insertFreeBoardComment", dto);
	}

	@Override
	public List<CommentDTO> selectFreeBoardComments(int num) throws Exception {
		return sqlSession.selectList("board.selectFreeBoardComments", num);
	}

	@Override
	public int insertFreeBoardReComment(ReCommentDTO dto) throws Exception {
		return sqlSession.insert("board.insertFreeBoardReComment", dto);
	}

	@Override
	public List<ReCommentDTO> selectFreeBoardReComments(int num) throws Exception {
		return sqlSession.selectList("board.selectFreeBoardReComments", num);
	}

	@Override
	public List<CommentDTO> selectFreeBoardCommentsCount(int num) throws Exception {
		return sqlSession.selectList("board.selectFreeBoardCommentsCount", num);
	}

	@Override
	public int updateFreeBoardComment(CommentDTO dto) throws Exception {
		return sqlSession.update("board.updateFreeBoardComment", dto);
	}

	@Override
	public int deleteFreeBoardComment(int num) throws Exception {
		return sqlSession.delete("board.deleteFreeBoardComment", num);
	}

	@Override
	public int updateFreeBoardReComment(ReCommentDTO dto) throws Exception {
		return sqlSession.update("board.updateFreeBoardReComment", dto);
	}

	@Override
	public int deleteFreeBoardReComment(int num) throws Exception {
		return sqlSession.update("board.deleteFreeBoardReComment", num);
	}

	@Override
	public String selectHasCommentRecommendHistory(Map<String, Integer> map) throws Exception {
		return sqlSession.selectOne("board.selectHasCommentRecommendHistory", map);
	}

	@Override
	public int insertCommentRecommendHistory(Map<String, Integer> map) throws Exception {
		return sqlSession.insert("board.insertCommentRecommendHistory", map);
	}

	@Override
	public int updateFreeBoardCommentRecommend(Map<String, Integer> map) throws Exception {
		return sqlSession.update("board.updateFreeBoardCommentRecommend", map);
	}

}