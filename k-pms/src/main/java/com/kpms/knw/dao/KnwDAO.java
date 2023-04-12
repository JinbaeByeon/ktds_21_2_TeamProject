package com.kpms.knw.dao;

import java.util.List;

import com.kpms.knw.vo.KnwVO;

public interface KnwDAO {
	
	public int createOneKnw(KnwVO knwVO);
	public List<KnwVO> readAllKnw(KnwVO knwVO);
}
