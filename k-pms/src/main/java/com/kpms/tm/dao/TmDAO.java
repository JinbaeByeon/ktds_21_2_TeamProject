package com.kpms.tm.dao;

import java.util.List;

import com.kpms.tm.vo.TmVO;

public interface TmDAO {

	public List<TmVO> readAllTmVO(TmVO tmVO);
	
	public List<TmVO> readAllTmVONopagination(String tmNm);
	
	public TmVO readOneTmVOByTmId(String tmId);
	
	public int createOneTm(TmVO tmVO);
	
	public int updateOneTm(TmVO tmVO);
	
	public int deleteOneTmByTmId(String tmId);
	
	public int deleteTmBySelectedTmId(List<String> tmId);
}
