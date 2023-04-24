package com.kpms.tmmbr.dao;

import java.util.List;

import com.kpms.tmmbr.vo.TmMbrVO;

public interface TmMbrDAO {
	
	public List<TmMbrVO> readAllTmMbrVO(String tmId);
	
	public int createOneTmMbr(TmMbrVO tmMbrVO);
	
	public int deleteOneTmMbrByTmMbrId(String tmMbrId);
	
	public int deleteTmMbrByTmId(String tmId);
	
	public int deleteTmMbrBySelectedTmMbrId(List<String> tmMbrId);

}
