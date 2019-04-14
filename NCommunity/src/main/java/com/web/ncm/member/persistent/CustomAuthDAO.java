package com.web.ncm.member.persistent;

import com.web.ncm.member.domain.MemberDTO;

public interface CustomAuthDAO {
	public MemberDTO selectMember(MemberDTO dto);
}
