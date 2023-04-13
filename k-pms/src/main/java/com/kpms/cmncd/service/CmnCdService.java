package com.kpms.cmncd.service;

import java.util.List;

import com.kpms.cmncd.vo.CmnCdVO;

public interface CmnCdService {
	
	public List<CmnCdVO> readAllCmnCd(CmnCdVO cmnCdVO);
	public boolean createOneCmnCd(CmnCdVO cmnCdVO);
	public boolean updateOneCmnCd(CmnCdVO cmnCdVO);
	public boolean deleteOneCmnCdByCdId(String cdId);
	public boolean deleteCmnCdBySelectedCmnCdId(List<String> cdIdList);
}
