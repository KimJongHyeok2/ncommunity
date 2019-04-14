package com.web.ncm.member.service;

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

}