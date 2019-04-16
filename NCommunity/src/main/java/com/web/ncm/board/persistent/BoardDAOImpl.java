package com.web.ncm.board.persistent;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.ncm.board.domain.BoardDTO;

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
	public int updateBoardRecommend(Map<String, Integer> map) throws Exception {
		return sqlSession.update("board.updateBoardRecommend", map);
	}

}
