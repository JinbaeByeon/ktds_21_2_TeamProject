package com.kpms.knw.service;

import java.util.List;

import com.kpms.knw.vo.KnwSearchVO;
import com.kpms.knw.vo.KnwVO;

public interface KnwService {

	public boolean createOneKnw(KnwVO knwVO);
	public List<KnwVO> readAllKnw(KnwSearchVO knwSearchVO);
	public KnwVO readOneKnwByKnwId(String KnwId);
	public boolean updateOneKnw(KnwVO knwVO);
	public boolean deleteOneKnw(String knwId);
	public boolean deleteKnwBySelectedKnwId(List<String> knwIdList);
}
