package com.kpms.prjtmmbr.dao;

import java.util.List;

import com.kpms.prjtmmbr.vo.PrjTmMbrSearchVO;
import com.kpms.prjtmmbr.vo.PrjTmMbrVO;

public interface PrjTmMbrDAO {
	
	public List<PrjTmMbrVO> readAllPrjTmMbrVO(PrjTmMbrSearchVO prjTmMbrSearchVO);
	public int createNewPrjTmMbr(PrjTmMbrVO prjTmMbrVO);
	public int deleteOnePrjTmMbrByPrjTmMbrId(String prjTmMbrId);
	public int updateOnePrjTmMbr(PrjTmMbrVO prjTmMbrVO);
	
}
