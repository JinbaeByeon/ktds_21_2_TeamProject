package com.kpms.prjtmmbr.service;

import java.util.List;

import com.kpms.prjtmmbr.vo.PrjTmMbrSearchVO;
import com.kpms.prjtmmbr.vo.PrjTmMbrVO;

public interface PrjTmMbrService {
	
	public List<PrjTmMbrVO> readAllPrjTmMbrVO(PrjTmMbrSearchVO prjTmMbrSearchVO);

}
