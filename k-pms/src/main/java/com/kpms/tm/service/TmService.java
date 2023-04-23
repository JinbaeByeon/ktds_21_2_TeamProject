package com.kpms.tm.service;

import java.util.List;

import com.kpms.tm.vo.TmSearchVO;
import com.kpms.tm.vo.TmVO;

public interface TmService {

	public List<TmVO> readAllTmVO(TmSearchVO tmSearchVO);
	
	public List<TmVO> readAllTmVONopagination(String depId);
	
	public TmVO readOneTmVOByTmId(String tmId);
	
	public boolean createOneTm(TmVO tmVO);
	
	public boolean updateOneTm(TmVO tmVO);
	
	public boolean updateOneTmAndTmMbr(TmVO tmVO);
	
	public boolean deleteOneTmByTmId(String tmId);
	
	public boolean deleteTmBySelectedTmId(List<String> tmId);
	
}
