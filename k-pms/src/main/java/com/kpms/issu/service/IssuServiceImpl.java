package com.kpms.issu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.issu.dao.IssuDAO;
import com.kpms.issu.vo.IssuVO;

@Service
public class IssuServiceImpl implements IssuService {

	@Autowired
	private IssuDAO issuDAO;
	
	@Override
	public boolean createOneIssu(IssuVO issuVO) {
		return issuDAO.createOneIssu(issuVO) > 0;
	}

	@Override
	public IssuVO readOneIssu(String issuId) {
		return issuDAO.readOneIssu(issuId);
	}

	@Override
	public List<IssuVO> readIssuList(IssuVO issuVO) {
		return issuDAO.readIssuList(issuVO);
	}

	@Override
	public boolean updateOneIssu(IssuVO issuVO) {
		return issuDAO.updateOneIssu(issuVO) > 0;
	}

	@Override
	public boolean updateIssuVwCnt(String issuId) {
		return issuDAO.updateIssuVwCnt(issuId) > 0;
	}

	@Override
	public boolean deleteOneIssu(String issuId) {
		return issuDAO.deleteOneIssu(issuId) > 0;
	}
	@Override
	public boolean deleteIssu(List<String> issuId) {
		return issuDAO.deleteIssu(issuId) > 0;
	}
}
