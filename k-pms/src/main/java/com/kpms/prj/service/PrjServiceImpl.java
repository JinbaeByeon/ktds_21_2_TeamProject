package com.kpms.prj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.prj.dao.PrjDAO;
import com.kpms.prj.vo.PrjVO;

@Service
public class PrjServiceImpl implements PrjService {
	
	@Autowired
	private PrjDAO prjDAO;

	@Override
	public List<PrjVO> readAllPrjVO(PrjVO prjVO) {
		return prjDAO.readAllPrjVO(prjVO);
	}

	@Override
	public boolean createOnePrj(PrjVO prjVO) {
		return prjDAO.createOnePrj(prjVO) > 0;
	}
	
}
