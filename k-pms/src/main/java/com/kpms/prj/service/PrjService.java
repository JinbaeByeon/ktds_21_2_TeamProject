package com.kpms.prj.service;

import java.util.List;

import com.kpms.cmncd.vo.CmnCdVO;
import com.kpms.prj.vo.PrjVO;

public interface PrjService {
	
	public List<PrjVO> readAllPrjVO(PrjVO prjVO);
	public List<PrjVO> readAllPrjVONoPagination(String prjNm);
	public PrjVO readOnePrjVOByPrjId(String prjId);
	public boolean createOnePrj(PrjVO prjVO);
	public boolean updateOnePrj(PrjVO prjVO);
	public boolean deleteOnePrjByPrjId(String prjId);
	public boolean deletePrjByPrjList(List<String> prjIdList);
	
}
