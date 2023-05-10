package com.kpms.tmmbr.dao;

import java.util.List;

import com.kpms.tmmbr.vo.TmMbrVO;

public interface TmMbrDAO {
	
	public List<TmMbrVO> readAllTmMbrVO(String tmId);
	
	public List<TmMbrVO> readAllTmMbrInTm(String tmId);
	
	public int createOneTmMbr(TmMbrVO tmMbrVO);
	
	public int deleteOneTmMbrByTmMbrId(String tmMbrId);
	
	public int deleteTmMbrByTmMbrId(String tmMbrId);
	
	public int deleteTmMbrByTmId(String tmId);
	
	public int deleteTmMbrBySelectedTmMbrId(List<String> tmMbrId);
	
	public int deleteTmMbrByDepId(String depId);

}
