package com.web.ncm.persistent;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.ncm.domain.EmailAccessDTO;
import com.web.ncm.domain.JoinDTO;

@Repository("JoinDAO")
public class JoinDAOImpl implements JoinDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public int checkOverlapID(String id) throws Exception {
		return sqlSession.selectOne("join.checkOverlapID", id);
	}
	
	@Override
	public int insertEKey(EmailAccessDTO dto) throws Exception {
		int count = sqlSession.insert("join.insertEKey", dto);
		return count;
	}

	@Override
	public String selectEKey(int ekey_num) throws Exception {
		return sqlSession.selectOne("join.selectEKey", ekey_num);
	}

	@Override
	public int insertMember(JoinDTO dto) throws Exception {
		return sqlSession.insert("join.insertMember", dto);
	}
	
}
