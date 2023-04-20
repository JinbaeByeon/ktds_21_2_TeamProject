package com.kpms.knwrpl.service;

import com.kpms.knwrpl.vo.KnwRplVO;

public interface KnwRplService {
	public boolean createNewKnwRpl(KnwRplVO knwRplVO);
	public boolean updateOneKnwRpl(KnwRplVO knwRplVO);
	public boolean deleteOneKnwRpl(String rplId);
}
