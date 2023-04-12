package com.kpms.lgntrylog.dao;

import java.util.List;

import com.kpms.emp.vo.EmpVO;
import com.kpms.lgntrylog.vo.LgnTryLogVO;

public interface LgnTryLogDAO {

	public int createLgnTryLog(EmpVO empVO);

	public List<LgnTryLogVO> readLgnTryLogByIp(String lgnTryIp);

}
