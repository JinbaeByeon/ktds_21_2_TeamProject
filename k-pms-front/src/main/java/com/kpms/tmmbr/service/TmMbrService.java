package com.kpms.tmmbr.service;

import java.util.List;

import com.kpms.tmmbr.vo.TmMbrVO;

public interface TmMbrService {
	
	public List<TmMbrVO> readAllTmMbrVO(String tmNm);

}
