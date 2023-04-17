package com.kpms.cmncd.dao;

import java.util.List;

import com.kpms.cmncd.vo.CmnCdVO;

public interface CmnCdDAO {
	
	public List<CmnCdVO> readAllCmnCd(CmnCdVO cmnCdVO);
	public List<CmnCdVO> readCmnCdType(CmnCdVO cmnCdVO);
	public List<CmnCdVO> readCmnCdNameByPrcdncCdId(String prcdncCdId);
	public int createOneCmnCd(CmnCdVO cmnCdVO);
	public int updateOneCmnCd(CmnCdVO cmnCdVO);
	public int deleteOneCmnCdByCdId(String cdId);
	public int deleteCmnCdBySelectedCmnCdId(List<String> cdIdList);
}
