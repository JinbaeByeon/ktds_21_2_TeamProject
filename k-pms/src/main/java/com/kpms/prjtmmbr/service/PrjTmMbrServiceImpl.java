package com.kpms.prjtmmbr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.prjtmmbr.dao.PrjTmMbrDAO;
import com.kpms.prjtmmbr.vo.PrjTmMbrSearchVO;
import com.kpms.prjtmmbr.vo.PrjTmMbrVO;

@Service
public class PrjTmMbrServiceImpl implements PrjTmMbrService {
	
	@Autowired
	private PrjTmMbrDAO prjTmMbrDAO;
	
	@Override
	public List<PrjTmMbrVO> readAllPrjTmMbrVO(PrjTmMbrSearchVO prjTmMbrSearchVO) {
		return prjTmMbrDAO.readAllPrjTmMbrVO(prjTmMbrSearchVO);
	}

}
