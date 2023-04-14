package com.kpms.tmmbr.dao;

import java.util.List;

import com.kpms.tmmbr.vo.TmMbrVO;

public interface TmMbrDAO {
	
	public int createNewTmMbr(TmMbrVO tmMbrVO);
	public int deleteOneTmMbrByTmMbrId(String TmMbrId);
	
}
