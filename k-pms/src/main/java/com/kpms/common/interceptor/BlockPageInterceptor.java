package com.kpms.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kpms.emp.vo.EmpVO;

public class BlockPageInterceptor extends HandlerInterceptorAdapter{

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		EmpVO admin = (EmpVO)request.getSession().getAttribute("__USER__");
		if(admin != null) {
			response.sendRedirect(request.getContextPath()+"/index");
			return false;
		}
		return true;
	}
}
