package com.web.ncm.member.service;

import java.util.Map;

import com.web.ncm.member.domain.MemberDTO;

public interface MemberService {
	public MemberDTO selectMember(MemberDTO dto) throws Exception;
	public int updateMemberProfile(Map<String, String> map) throws Exception;
	public MemberDTO selectMemberInfo(int num) throws Exception;
	public int updateMemberNickname(Map<String, String> map) throws Exception;
}