package com.kpms.atchfl.dao;

import java.util.List;

import com.kpms.atchfl.vo.AtchFlVO;

public interface AtchFlDAO {

	public long doGetGroupId();
	public int doCreateNewAtchFl(AtchFlVO atchFlVO);
	public int createNewAtchFls(List<AtchFlVO> fileList);
}
