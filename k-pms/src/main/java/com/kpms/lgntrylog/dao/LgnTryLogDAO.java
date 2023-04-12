package com.kpms.lgntrylog.dao;

import com.kpms.lgntrylog.vo.LgnTryLogVO;

public interface LgnTryLogDAO {

	int createLgnTryLog(LgnTryLogVO lgnTryLog);
	int updateLgnTryLog(LgnTryLogVO lgnTryLog);

	LgnTryLogVO readLgnTryLog(LgnTryLogVO lgnTryLog);

}
