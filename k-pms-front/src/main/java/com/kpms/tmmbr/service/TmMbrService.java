package com.kpms.tmmbr.service;

import java.util.List;

import com.kpms.tmmbr.vo.TmMbrVO;

public interface TmMbrService {
	
	public List<TmMbrVO> readAllTmMbrVO(String tmId);
	
	public List<TmMbrVO> readAllTmMbrInTm(String tmId);
	
	public boolean createOneTmMbr(TmMbrVO tmMbrVO);
	
	public boolean deleteOneTmMbrByTmMbrId(String tmMbrId);
	
	public boolean deleteTmMbrBySelectedTmMbrId(List<String> tmMbrId);
	
}
