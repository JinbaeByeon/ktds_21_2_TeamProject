package com.kpms.atchfl.dao;

import com.kpms.atchfl.vo.AtchFlVO;

public interface AtchFlDAO {

	public long doGetGroupId();
	public int doCreateNewAtchFl(AtchFlVO atchFlVO);
}
