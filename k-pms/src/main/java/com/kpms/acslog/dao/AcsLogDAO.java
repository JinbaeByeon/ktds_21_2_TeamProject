package com.kpms.acslog.dao;

import java.util.List;

import com.kpms.acslog.vo.AcsLogExcelVO;
import com.kpms.acslog.vo.AcsLogVO;

public interface AcsLogDAO {
	
	public int createAcsLog(AcsLogVO acsLog);

	public List<AcsLogVO> readAllAcsLog(AcsLogVO acsLog);

	public List<AcsLogExcelVO> readAllAcsLogToExcel(AcsLogVO acsLogVO);
}
