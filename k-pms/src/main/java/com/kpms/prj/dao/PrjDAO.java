package com.kpms.prj.dao;

import java.util.List;

import com.kpms.prj.vo.PrjVO;

public interface PrjDAO {
	
	public List<PrjVO> readAllPrjVO(PrjVO prjVO);
	public int createOnePrj(PrjVO prjVO);
	
}
