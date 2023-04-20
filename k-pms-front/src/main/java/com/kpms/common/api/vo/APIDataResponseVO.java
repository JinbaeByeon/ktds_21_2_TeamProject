package com.kpms.common.api.vo;

public class APIDataResponseVO extends APIResponseVO {

	private Object data;

	public APIDataResponseVO(String status, Object data) {
		super(status);
		this.data = data;
	}
	
	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

}
