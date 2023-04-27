package com.kpms.deplog.dao;

import java.util.List;

import com.kpms.deplog.vo.DepLogVO;
import com.kpms.emp.vo.EmpChngDepVO;

public interface DepLogDAO {
	
	public List<DepLogVO> readAllDepLogVO(DepLogVO depLogVO);
	
	public int createDepLog(EmpChngDepVO empChngDepVO);
	
}
