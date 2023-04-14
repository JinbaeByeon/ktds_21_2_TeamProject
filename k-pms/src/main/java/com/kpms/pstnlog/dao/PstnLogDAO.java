package com.kpms.pstnlog.dao;

import java.util.List;

import com.kpms.pstnlog.vo.PstnLogVO;

public interface PstnLogDAO {
	
	public List<PstnLogVO> readAllPstnLog(PstnLogVO pstnLogVO);
	
	public int createPstnLog(PstnLogVO pstnLogVO);

}
