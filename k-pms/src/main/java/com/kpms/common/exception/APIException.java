package com.kpms.common.exception;

public class APIException extends RuntimeException {

	private static final long serialVersionUID = 546906913054676142L;
	
	private String errorCode;
	
	public APIException(String errorCode, String msg) {
		super(msg);
		this.errorCode = errorCode;
	}
	
	public String getErrorCode() {
		return errorCode;
	}
}
