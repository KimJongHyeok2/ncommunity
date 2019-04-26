package com.web.ncm.persistent;

import com.web.ncm.domain.MemberDTO;

public interface CustomAuthDAO {
	public MemberDTO selectMember(MemberDTO dto);
}
