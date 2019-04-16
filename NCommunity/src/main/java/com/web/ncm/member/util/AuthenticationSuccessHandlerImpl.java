package com.web.ncm.member.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.web.ncm.member.domain.MemberDTO;
import com.web.ncm.member.persistent.CustomAuthDAO;

public class AuthenticationSuccessHandlerImpl implements AuthenticationSuccessHandler {
	
	@Inject
	private SqlSession sqlSession;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		MemberDTO dto = new MemberDTO();
		boolean urlFlag = false;

		if(request.getParameter("mem_id") != null && request.getParameter("mem_pw") != null) {
			dto.setMem_id(request.getParameter("mem_id"));
			dto.setMem_pw(request.getParameter("mem_pw"));
		}

		try {
			CustomAuthDAO dao = sqlSession.getMapper(CustomAuthDAO.class);
			dto = dao.selectMember(dto);
			
			request.getSession().setAttribute("num", dto.getMem_num());
			request.getSession().setAttribute("id", dto.getMem_id());
			request.getSession().setAttribute("nickname", dto.getMem_nickname());
			
			if(request.getSession().getAttribute("urlTemp") != null) {
				urlFlag = true;
				response.setContentType("text/html; charset=utf-8");
				PrintWriter output = response.getWriter();
				output.println("<script>location.href='" + ((String)request.getSession().getAttribute("urlTemp")) + "'</script>");
				request.getSession().removeAttribute("urlTemp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(!urlFlag) {
			response.sendRedirect(request.getContextPath());
		}
		
	}
	
}
