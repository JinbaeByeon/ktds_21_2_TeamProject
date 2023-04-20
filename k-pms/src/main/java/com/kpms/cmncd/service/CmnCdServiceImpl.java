package com.kpms.cmncd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.cmncd.dao.CmnCdDAO;
import com.kpms.cmncd.vo.CmnCdSearchVO;
import com.kpms.cmncd.vo.CmnCdVO;
import com.kpms.common.exception.APIException;

@Service
public class CmnCdServiceImpl implements CmnCdService {

	@Autowired
	private CmnCdDAO cmnCdDAO;
	
	@Override
	public List<CmnCdVO> readAllCmnCd(CmnCdSearchVO cmnCdSearchVO) {
		return cmnCdDAO.readAllCmnCd(cmnCdSearchVO);
	}
	
	@Override
	public List<CmnCdVO> readCmnCdType() {
		return cmnCdDAO.readCmnCdType();
	}
	
	@Override
	public List<CmnCdVO> readCmnCdNameByPrcdncCdId(String prcdncCdId) {
		return cmnCdDAO.readCmnCdNameByPrcdncCdId(prcdncCdId);
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
	public boolean deleteOneCmnCdByCdId(String cdId) {
		return cmnCdDAO.deleteOneCmnCdByCdId(cdId) > 0;
	}
	
	@Override
	public boolean deleteCmnCdBySelectedCmnCdId(List<String> cdIdList) {
		int delCount = cmnCdDAO.deleteCmnCdBySelectedCmnCdId(cdIdList);
		boolean isSuccess = (delCount == cdIdList.size());
		if(!isSuccess) {
			throw new APIException("500", "삭제에 실패하였습니다.");
		}
		return isSuccess;
	}

	
}
