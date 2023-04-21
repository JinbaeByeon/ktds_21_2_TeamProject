package com.kpms.prjtmmbr.dao;

import com.kpms.prjtmmbr.vo.PrjTmMbrVO;

public interface PrjTmMbrDAO {
	
	public int createNewPrjTmMbr(PrjTmMbrVO prjTmMbrVO);
	public int deleteOnePrjTmMbrByPrjTmMbrId(String prjTmMbrId);
	public int updateOnePrjTmMbr(PrjTmMbrVO prjTmMbrVO);

}
