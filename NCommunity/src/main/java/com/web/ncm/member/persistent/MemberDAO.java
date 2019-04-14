package com.web.ncm.member.persistent;

import com.web.ncm.member.domain.MemberDTO;

public interface MemberDAO {
	public MemberDTO selectMember(MemberDTO dto) throws Exception;
}