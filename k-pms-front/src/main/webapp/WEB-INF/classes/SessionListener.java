package com.kpms.common.listener;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.kpms.common.handler.SessionHandler;
import com.kpms.emp.vo.EmpVO;

public class SessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent hse) {
		HttpSession session = hse.getSession();
		EmpVO user = (EmpVO)session.getAttribute("__USER__");
		
		SessionHandler.get().setSession(user.getEmpId(), session);
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent hse) {
		EmpVO user = (EmpVO)hse.getSession().getAttribute("__USER__");
		
		SessionHandler.get().clearSession(user.getEmpId());
	}
}
