package com.kpms.pstnlog.service;

import java.util.List;

import com.kpms.pstnlog.vo.PstnLogVO;

public interface PstnLogService {
	
	public List<PstnLogVO> readAllPstnLog(PstnLogVO pstnLogVO);
	
}
