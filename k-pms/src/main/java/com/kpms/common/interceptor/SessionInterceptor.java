package com.kpms.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kpms.emp.vo.EmpVO;

public class SessionInterceptor extends HandlerInterceptorAdapter{

	private static final Logger logger = LoggerFactory.getLogger(SessionInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		EmpVO user = (EmpVO)request.getSession().getAttribute("__USER__");
		if(user==null) {
			logger.debug("Session이 존재하지 않습니다.");
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		return true;
	}
}
