package com.kpms.knwrpl.dao;

import com.kpms.knwrpl.vo.KnwRplVO;

public interface KnwRplDAO {

	public int createNewKnwRpl(KnwRplVO knwRplVO);
	public int updateOneKnwRpl(KnwRplVO knwRplVO);
	public int deleteOneKnwRpl(String rplId);
	public int deleteSelectedKnwRplByKnwId(String knwId);
}
