package com.kpms.prj.service;

import java.util.List;

import com.kpms.prj.vo.PrjVO;

public interface PrjService {
	
	public List<PrjVO> readAllPrjVO(PrjVO prjVO);
	public boolean createOnePrj(PrjVO prjVO);
	
}
