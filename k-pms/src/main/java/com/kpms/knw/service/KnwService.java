package com.kpms.knw.service;

import java.util.List;

import com.kpms.knw.vo.KnwVO;

public interface KnwService {

	public boolean createOneKnw(KnwVO knwVO);
	public List<KnwVO> readAllKnw(KnwVO knwVO);
}
