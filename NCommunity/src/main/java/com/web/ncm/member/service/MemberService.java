package com.web.ncm.member.service;

import com.web.ncm.member.domain.MemberDTO;

public interface MemberService {
	public MemberDTO selectMember(MemberDTO dto) throws Exception;
}