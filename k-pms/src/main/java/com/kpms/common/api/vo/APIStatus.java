package com.kpms.common.api.vo;

public interface APIStatus {

	public static final String OK = "200 OK";
	public static final String MISSING_ARG = "400";
	public static final String FAIL = "500";
	public static final String NOT_FOUND = "404";
	/**
	 * 데이터 불일치
	 */
	public static final String INCORRECT = "401";
	public static final String OVER_LEN_ARG = "401";
	
	
}
