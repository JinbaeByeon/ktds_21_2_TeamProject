package com.kpms.prjlog.dao;

import java.util.List;

import com.kpms.prjlog.vo.PrjLogVO;

public interface PrjLogDAO {
	
	public int createPrjLog(PrjLogVO prjLogVO);
	
	public List<PrjLogVO> readAllPrjLog(PrjLogVO prjLogVO);

}
