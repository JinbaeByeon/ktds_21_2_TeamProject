package com.kpms.prj.service;

import java.util.List;

import com.kpms.prj.vo.PrjSearchVO;
import com.kpms.prj.vo.PrjVO;

public interface PrjService {
	
	public List<PrjVO> readAllPrjVO(PrjSearchVO prjSearchVO);
	public List<PrjVO> readAllPrjVONoPagination(String prjNm);
	public PrjVO readOnePrjVOByPrjId(String prjId);
	public boolean createOnePrj(PrjVO prjVO);
	public boolean updateOnePrj(PrjVO prjVO);
	public boolean deleteOnePrjByPrjId(String prjId);
	public boolean deletePrjByPrjList(List<String> prjIdList);
	
}
