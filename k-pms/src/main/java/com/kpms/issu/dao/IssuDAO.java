package com.kpms.issu.dao;

import java.util.List;

import com.kpms.issu.vo.IssuVO;

public interface IssuDAO {
	public int createOneIssu(IssuVO issuVO);

	public IssuVO readOneIssu(String issuId);

	public List<IssuVO> readIssuList(IssuVO issuVO);

	public int updateOneIssu(IssuVO issuVO);
	public int updateIssuVwCnt(String issuId);
	
	public int deleteOneIssu(String issuId);

	public int deleteIssu(List<String> issuId);

	public int deleteIssuByReqId(String reqId);
	
	public int deleteIssuByPrjId(String prjId);
}
