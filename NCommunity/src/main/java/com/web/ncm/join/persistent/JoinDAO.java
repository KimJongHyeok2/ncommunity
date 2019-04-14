package com.web.ncm.join.persistent;

import com.web.ncm.join.domain.EmailAccessDTO;
import com.web.ncm.join.domain.JoinDTO;

public interface JoinDAO {
	public int checkOverlapID(String id) throws Exception;
	public int insertEKey(EmailAccessDTO dto) throws Exception;
	public String selectEKey(int ekey_num) throws Exception;
	public int insertMember(JoinDTO dto) throws Exception;
}