package com.web.ncm.persistent;

import java.util.Map;

import com.web.ncm.domain.MemberDTO;

public interface MemberDAO {
	public MemberDTO selectMember(MemberDTO dto) throws Exception;
	public int updateMemberProfile(Map<String, String> map) throws Exception;
	public MemberDTO selectMemberInfo(int num) throws Exception;
	public int updateMemberNickname(Map<String, String> map) throws Exception;
}