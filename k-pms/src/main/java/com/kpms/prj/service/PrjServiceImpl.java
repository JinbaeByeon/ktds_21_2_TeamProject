package com.kpms.prj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.exception.APIException;
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

	@Override
	public boolean updateOnePrj(PrjVO prjVO) {
		return prjDAO.updateOnePrj(prjVO) > 0;
	}

	@Override
	public boolean deleteOnePrjByPrjId(String prjId) {
		return prjDAO.deleteOnePrjByPrjId(prjId) > 0;
	}

	@Override
	public boolean deletePrjByPrjList(List<String> prjIdList) {
		boolean isSuccess = prjDAO.deletePrjByPrjList(prjIdList) == prjIdList.size();
		if (!isSuccess) {
			throw new APIException("500", "삭제실패");
		}
		return isSuccess;
	}
	
}
