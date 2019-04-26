package com.web.ncm.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.web.ncm.domain.EmailAccessDTO;
import com.web.ncm.domain.JoinDTO;
import com.web.ncm.persistent.JoinDAO;

@Service("JoinService")
public class JoinServiceImpl implements JoinService {

	@Inject
	private JoinDAO dao;
	
	@Override
	public int insertEKey(EmailAccessDTO dto) throws Exception {
		int count = dao.insertEKey(dto);
		return count;
	}
	
	@Override
	public String selectEKey(int ekey_num) throws Exception {
		return dao.selectEKey(ekey_num);
	}

	@Override
	public int checkOverlapID(String id) throws Exception {
		return dao.checkOverlapID(id);
	}

	@Override
	public int insertMember(JoinDTO dto) throws Exception {
		return dao.insertMember(dto);
	}

}
