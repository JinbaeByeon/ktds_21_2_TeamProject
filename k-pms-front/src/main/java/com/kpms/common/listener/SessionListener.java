package com.kpms.common.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kpms.common.handler.SessionHandler;
import com.kpms.emp.vo.EmpVO;

public class SessionListener implements HttpSessionListener {
	private static final Logger logger = LoggerFactory.getLogger(SessionListener.class);
	@Override
	public void sessionCreated(HttpSessionEvent hse) {
		HttpSession session = hse.getSession();
		logger.debug("sessionCreated - sessionId:" + session.getId() + " /session: " + session);
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent hse) {
		EmpVO user = (EmpVO)hse.getSession().getAttribute("__USER__");
		
		SessionHandler.get().clearSession(user.getEmpId());
	}
}
