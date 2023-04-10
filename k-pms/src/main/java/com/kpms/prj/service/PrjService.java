package com.kpms.prj.service;

import java.util.List;

import com.kpms.prj.vo.PrjVO;

public interface PrjService {
	
	public List<PrjVO> readAllPrjVO(PrjVO prjVO);
	public boolean createOnePrj(PrjVO prjVO);
	public boolean updateOnePrj(PrjVO prjVO);
	public boolean deleteOnePrjByPrjId(String prjId);
	public boolean deletePrjByPrjList(List<String> prjIdList);
	
}
