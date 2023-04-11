package com.kpms.common.vo;

import java.util.Calendar;

import com.kpms.common.util.CalendarUtil;


public abstract class AbstractPagingVO extends AbstractVO{
	private String startDt;
	private String endDt;
	
	private int pageNo;
	private int viewCnt;
	private int pageCnt;
	private int totalCount;
	private int lastPage;
	private int lastGroup;
	private int rnum;

	protected AbstractPagingVO() {
		pageNo = 0;
		viewCnt = 2;
		pageCnt = 3;
	}

	public String getStartDt() {
		return startDt;
	}

	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}

	public String getEndDt() {
		return endDt;
	}

	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	public int getPageCnt() {
		return pageCnt;
	}

	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getLastGroup() {
		return lastGroup;
	}

	public void setLastGroup(int lastGroup) {
		this.lastGroup = lastGroup;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	
	public void setPeriod() {
		// Calendar
		Calendar cal = Calendar.getInstance();
		
		if(endDt == null) {
			setEndDt(CalendarUtil.getDate(cal));
		}
		if(startDt == null) {
			cal.add(Calendar.MONTH, -1);
			setStartDt(CalendarUtil.getDate(cal));
		}
	}

	
}
