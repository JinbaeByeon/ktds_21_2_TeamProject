package com.kpms.cmncd.dao;

import java.util.List;

import com.kpms.cmncd.vo.CmnCdVO;

public interface CmnCdDAO {
	
	public List<CmnCdVO> readAllCmnCd(CmnCdVO cmnCdVO);
	public int createOneCmnCd(CmnCdVO cmnCdVO);
	public int updateOneCmnCd(CmnCdVO cmnCdVO);
	public int deleteOneCmnCdByCdId(int cdId);
}
