package com.kpms.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kpms.acslog.service.AcsLogService;
import com.kpms.acslog.vo.AcsLogVO;
import com.kpms.emp.vo.EmpVO;

public class SessionInterceptor extends HandlerInterceptorAdapter{

	private static final Logger logger = LoggerFactory.getLogger(SessionInterceptor.class);
	
	@Autowired
	private AcsLogService acsLogService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		EmpVO user = (EmpVO)request.getSession().getAttribute("__USER__");
		if(user==null) {
			logger.debug("Session이 존재하지 않습니다.");
			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		
		AcsLogVO acsLogVO = new AcsLogVO();
		acsLogVO.setCrtr(user.getEmpId());
		String acsLog = request.getRequestURL().toString();
		String qryStr = request.getQueryString();
		if(qryStr != null) {
			acsLog += qryStr;
		}
		acsLogVO.setAcsLog(acsLog);
		acsLogService.createAcsLog(acsLogVO);
		return true;
	}
}
