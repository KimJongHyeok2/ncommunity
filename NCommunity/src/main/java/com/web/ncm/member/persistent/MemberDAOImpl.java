package com.web.ncm.member.persistent;

import java.util.Map;

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

	@Override
	public int updateMemberProfile(Map<String, String> map) throws Exception {
		return sqlSession.update("member.updateMemberProfile", map);
	}

	@Override
	public MemberDTO selectMemberInfo(int num) throws Exception {
		return sqlSession.selectOne("member.selectMemberInfo", num);
	}

	@Override
	public int updateMemberNickname(Map<String, String> map) throws Exception {
		return sqlSession.update("member.updateMemberNickname", map);
	}

}