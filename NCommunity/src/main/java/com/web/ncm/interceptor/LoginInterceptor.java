package com.web.ncm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String urlTemp = null;
		
		if(request.getSession().getAttribute("num") == null) {
			urlTemp = request.getRequestURI().toString() + "?" + request.getQueryString();
			
			request.getSession().setAttribute("urlTemp", urlTemp);
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}

}
