package com.kpms.prjlog.service;

import java.util.List;

import com.kpms.prjlog.vo.PrjLogVO;

public interface PrjLogService {

	public List<PrjLogVO> readAllPrjLog(PrjLogVO prjLogVO);
}
