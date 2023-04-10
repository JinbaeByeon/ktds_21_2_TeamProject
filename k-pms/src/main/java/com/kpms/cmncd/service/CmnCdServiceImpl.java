package com.kpms.cmncd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.cmncd.dao.CmnCdDAO;
import com.kpms.cmncd.vo.CmnCdVO;

@Service
public class CmnCdServiceImpl implements CmnCdService {

	@Autowired
	private CmnCdDAO cmnCdDAO;
	
	@Override
	public List<CmnCdVO> readAllCmnCd(CmnCdVO cmnCdVO) {
		return cmnCdDAO.readAllCmnCd(cmnCdVO);
	}

	@Override
	public boolean createOneCmnCd(CmnCdVO cmnCdVO) {
		return cmnCdDAO.createOneCmnCd(cmnCdVO) > 0;
	}

	@Override
	public boolean updateOneCmnCd(CmnCdVO cmnCdVO) {
		return cmnCdDAO.updateOneCmnCd(cmnCdVO) > 0;
	}

	@Override
	public boolean deleteOneCmnCdByCdId(int cdId) {
		return cmnCdDAO.deleteOneCmnCdByCdId(cdId) > 0;
	}

	
}
