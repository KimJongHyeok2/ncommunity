package com.web.ncm.member.persistent;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.web.ncm.member.domain.MemberDTO;

@Repository("MemberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sqlSession;
	
	@Override
	public MemberDTO selectMember(MemberDTO dto) throws Exception {
		return sqlSession.selectOne("member.selectMember", dto);
	}

}