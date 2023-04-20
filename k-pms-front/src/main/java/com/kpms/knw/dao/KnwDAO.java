package com.kpms.knw.dao;

import java.util.List;

import com.kpms.knw.vo.KnwSearchVO;
import com.kpms.knw.vo.KnwVO;

public interface KnwDAO {
	
	public int createOneKnw(KnwVO knwVO);
	public List<KnwVO> readAllKnw(KnwSearchVO knwSearchVO);
	public KnwVO readOneKnwByKnwId(String KnwId);
	public int updateOneKnw(KnwVO knwVO);
	public int deleteOneKnw(String knwId);
	public int deleteKnwBySelectedKnwId(List<String> knwIdList);
}
