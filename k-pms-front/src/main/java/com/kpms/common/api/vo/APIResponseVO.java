package com.kpms.common.api.vo;

public class APIResponseVO {

	private String status;
	private String message;
	private String errorCode;
	private String redirectURL;

	public APIResponseVO() {
		this.status = "";
		this.message= "";
		this.errorCode="";
		this.redirectURL="";
	}
	public APIResponseVO(String status) {
		super();
		this.status = status;
	}
	public APIResponseVO(String status, String redirectURL) {
		super();
		this.status = status;
		this.redirectURL = redirectURL;
	}
	public APIResponseVO(String status, String message, String redirectURL) {
		super();
		this.status = status;
		this.message = message;
		this.redirectURL = redirectURL;
	}
	public APIResponseVO(String status, String message, String errorCode, String redirectURL) {
		this.status = status;
		this.message = message;
		this.errorCode = errorCode;
		this.redirectURL = redirectURL;
	}


	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}

	public String getRedirectURL() {
		return redirectURL;
	}

	public void setRedirectURL(String redirectURL) {
		this.redirectURL = redirectURL;
	}
}
