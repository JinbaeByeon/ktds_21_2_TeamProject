package com.kpms.pstnlog.dao;

import java.util.List;

import com.kpms.emp.vo.EmpChngPstnVO;
import com.kpms.pstnlog.vo.PstnLogVO;

public interface PstnLogDAO {
	
	public List<PstnLogVO> readAllPstnLogVO(PstnLogVO pstnLogVO);
	
	public int createPstnLog(EmpChngPstnVO empChngPstnVO);

}
