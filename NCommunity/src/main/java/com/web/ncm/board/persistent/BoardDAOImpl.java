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
	public int updateFreeBoardViewcnt(int num) throws Exception {
		return sqlSession.update("board.updateFreeBoardViewcnt", num);
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
	public String selectHasRecommendHistory(Map<String, String> map) throws Exception {
		return sqlSession.selectOne("board.selectHasRecommendHistory", map);
	}

	@Override
	public int insertRecommendHistory(Map<String, String> map) throws Exception {
		return sqlSession.insert("board.insertRecommendHistory", map);
	}

	@Override
	public int updateFreeBoardRecommend(Map<String, String> map) throws Exception {
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
	public List<CommentDTO> selectFreeBoardComments_popular(int num) throws Exception {
		return sqlSession.selectList("board.selectFreeBoardComments_popular", num);
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
	public int deleteFreeBoardReComments(int num) throws Exception {
		return sqlSession.update("board.deleteFreeBoardReComments", num);
	}

	@Override
	public String selectHasCommentRecommendHistory(Map<String, String> map) throws Exception {
		return sqlSession.selectOne("board.selectHasCommentRecommendHistory", map);
	}

	@Override
	public int insertCommentRecommendHistory(Map<String, String> map) throws Exception {
		return sqlSession.insert("board.insertCommentRecommendHistory", map);
	}

	@Override
	public int updateFreeBoardCommentRecommend(Map<String, String> map) throws Exception {
		return sqlSession.update("board.updateFreeBoardCommentRecommend", map);
	}

	@Override
	public List<BoardDTO> selectFreeBoardWeek(Map<String, String> map) throws Exception {
		return sqlSession.selectList("board.selectFreeBoardWeek", map);
	}

	@Override
	public List<BoardDTO> selectFreeBoardToday() throws Exception {
		return sqlSession.selectList("board.selectFreeBoardToday");
	}

	@Override
	public int insertVideoBoard(BoardDTO dto) throws Exception {
		return sqlSession.insert("board.insertVideoBoard", dto);
	}

	@Override
	public BoardDTO selectVideoView(int num) throws Exception {
		return sqlSession.selectOne("board.selectVideoView", num);
	}

	@Override
	public int updateVideoBoardViewcnt(int num) throws Exception {
		return sqlSession.update("board.updateVideoBoardViewcnt", num);
	}

	@Override
	public List<BoardDTO> selectVideoBoard(Map<String, Integer> page) throws Exception {
		return sqlSession.selectList("board.selectVideoBoard", page);
	}

	@Override
	public int selectVideoBoardCount() throws Exception {
		return sqlSession.selectOne("board.selectVideoBoardCount");
	}

	@Override
	public int updateVideoBoard(BoardDTO dto) throws Exception {
		return sqlSession.update("board.updateVideoBoard", dto);
	}

	@Override
	public int deleteVideoBoard(int num) throws Exception {
		return sqlSession.update("board.deleteVideoBoard", num);
	}

	@Override
	public int updateVideoBoardRecommend(Map<String, String> map) throws Exception {
		return sqlSession.update("board.updateVideoBoardRecommend", map);
	}

	@Override
	public int insertVideoBoardComment(CommentDTO dto) throws Exception {
		return sqlSession.insert("board.insertVideoBoardComment", dto);
	}

	@Override
	public List<CommentDTO> selectVideoBoardComments(int num) throws Exception {
		return sqlSession.selectList("board.selectVideoBoardComments", num);
	}

	@Override
	public List<CommentDTO> selectVideoBoardComments_popular(int num) throws Exception {
		return sqlSession.selectList("board.selectVideoBoardComments_popular", num);
	}

	@Override
	public int insertVideoBoardReComment(ReCommentDTO dto) throws Exception {
		return sqlSession.insert("board.insertVideoBoardReComment", dto);
	}

	@Override
	public List<ReCommentDTO> selectVideoBoardReComments(int num) throws Exception {
		return sqlSession.selectList("board.selectVideoBoardReComments", num);
				
	}

	@Override
	public List<CommentDTO> selectVideoBoardCommentsCount(int num) throws Exception {
		return sqlSession.selectList("board.selectVideoBoardCommentsCount", num);
	}

	@Override
	public int updateVideoBoardCommentRecommend(Map<String, String> map) throws Exception {
		return sqlSession.update("board.updateVideoBoardCommentRecommend", map);
	}

	@Override
	public int updateVideoBoardComment(CommentDTO dto) throws Exception {
		return sqlSession.update("board.updateVideoBoardComment", dto);
	}

	@Override
	public int updateVideoBoardReComment(ReCommentDTO dto) throws Exception {
		return sqlSession.update("board.updateVideoBoardReComment", dto);
	}

	@Override
	public int deleteVideoBoardComment(int num) throws Exception {
		return sqlSession.update("board.deleteVideoBoardComment", num);
	}

	@Override
	public int deleteVideoBoardReComment(int num) throws Exception {
		return sqlSession.update("board.deleteVideoBoardReComment", num);
	}

	@Override
	public int deleteVideoBoardReComments(int num) throws Exception {
		return sqlSession.update("board.deleteVideoBoardReComments", num);
	}

}
