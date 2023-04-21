package com.kpms.common.exception;

public class APIArgsException extends RuntimeException{

	private static final long serialVersionUID = 8656789365734856679L;

	private String errorCode;
	
	public APIArgsException(String errorCode, String msg) {
		super(msg);
		this.errorCode = errorCode;
	}
	
	public String getErrorCode() {
		return errorCode;
	}
}