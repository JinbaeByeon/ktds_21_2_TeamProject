package com.kpms.common.handler;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

public class SessionHandler {
	private static SessionHandler sessionHandler;
	
	private Map<String,HttpSession> mapIdSession;
	
	public static SessionHandler get() {
		if(sessionHandler== null) {
			sessionHandler = new SessionHandler();
		}
		return sessionHandler;
	}
	
	private SessionHandler() {
		mapIdSession = new HashMap<>();
	}
	
	public boolean isAlreadyLogin(String empId) {
		return mapIdSession.containsKey(empId);
	}
	
	public HttpSession getSessionById(String empId) {
		return mapIdSession.get(empId);
	}
	
	public void setSession(String empId, HttpSession session) {
		mapIdSession.put(empId, session);
	}
	public void clearSession(String empId) {
		mapIdSession.remove(empId);
	}
}
