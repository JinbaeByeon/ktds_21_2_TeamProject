package com.kpms.tmmbr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.tmmbr.dao.TmMbrDAO;
import com.kpms.tmmbr.vo.TmMbrVO;

@Service
public class TmMbrServiceImpl implements TmMbrService {
	
	@Autowired
	private TmMbrDAO tmMbrDAO;

	@Override
	public List<TmMbrVO> readAllTmMbrVO(String tmNm) {
		return tmMbrDAO.readAllTmMbrVO(tmNm);
	}

}
