package com.kpms.issu.service;

import java.util.List;

import com.kpms.issu.vo.IssuVO;

public interface IssuService {

	public boolean createOneIssu(IssuVO issuVO);

	public IssuVO readOneIssu(String issuId);

	public List<IssuVO> readIssuList(IssuVO issuVO);

	public boolean updateOneIssu(IssuVO issuVO);
	public boolean updateIssuVwCnt(String issuId);
	
	public boolean deleteOneIssu(String issuId);

	public boolean deleteIssu(List<String> issuId);
}
