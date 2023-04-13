package com.kpms.prj.dao;

import java.util.List;

import com.kpms.prj.vo.PrjVO;

public interface PrjDAO {
	
	public List<PrjVO> readAllPrjVO(PrjVO prjVO);
	public List<PrjVO> readAllPrjVONoPagination(String prjNm);
	public PrjVO readOnePrjVOByPrjId(String prjId);
	public int createOnePrj(PrjVO prjVO);
	public int updateOnePrj(PrjVO prjVO);
	public int deleteOnePrjByPrjId(String prjId);
	public int deletePrjByPrjList(List<String> prjIdList);

}
