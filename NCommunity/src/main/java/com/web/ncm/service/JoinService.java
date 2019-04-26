package com.web.ncm.service;

import com.web.ncm.domain.EmailAccessDTO;
import com.web.ncm.domain.JoinDTO;

public interface JoinService {
	public int checkOverlapID(String id) throws Exception; 
	public int insertEKey(EmailAccessDTO dto) throws Exception;
	public String selectEKey(int ekey_num) throws Exception;
	public int insertMember(JoinDTO dto) throws Exception;
}