package com.web.ncm.member.service;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.ncm.member.domain.MemberDTO;
import com.web.ncm.member.persistent.MemberDAO;

@Service("MemberSerivce")
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	@Override
	public MemberDTO selectMember(MemberDTO dto) throws Exception {
		return dao.selectMember(dto);
	}

	@Override
	public int updateMemberProfile(Map<String, String> map) throws Exception {
		return dao.updateMemberProfile(map);
	}

	@Override
	public MemberDTO selectMemberInfo(int num) throws Exception {
		return dao.selectMemberInfo(num);
	}

	@Override
	public int updateMemberNickname(Map<String, String> map) throws Exception {
		return dao.updateMemberNickname(map);
	}

}