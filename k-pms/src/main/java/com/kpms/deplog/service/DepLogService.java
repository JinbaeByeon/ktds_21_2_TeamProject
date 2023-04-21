package com.kpms.deplog.service;

import java.util.List;

import com.kpms.deplog.vo.DepLogVO;

public interface DepLogService {

	public List<DepLogVO> readAllDepLogVO(DepLogVO depLogVO);
	
}
