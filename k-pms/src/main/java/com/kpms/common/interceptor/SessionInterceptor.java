package com.kpms.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kpms.emp.vo.EmpVO;

public class SessionInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		EmpVO user = (EmpVO)request.getSession().getAttribute("__USER__");
		if(user==null) {
			response.sendRedirect(request.getContextPath());
			return false;
		}
		return true;
	}
}
