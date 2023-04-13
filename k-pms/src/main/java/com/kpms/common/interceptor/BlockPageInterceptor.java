package com.kpms.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kpms.emp.vo.EmpVO;

public class BlockPageInterceptor extends HandlerInterceptorAdapter{

	private static final Logger logger = LoggerFactory.getLogger(BlockPageInterceptor.class);
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		EmpVO admin = (EmpVO)request.getSession().getAttribute("__USER__");
		if(admin != null) {
			logger.debug("Session이 존재합니다");
			response.sendRedirect(request.getContextPath()+"/index");
			return false;
		}
		return true;
	}
}
