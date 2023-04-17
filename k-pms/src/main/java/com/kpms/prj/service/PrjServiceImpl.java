package com.kpms.prj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.cmncd.dao.CmnCdDAO;
import com.kpms.cmncd.vo.CmnCdVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.common.util.StringUtil;
import com.kpms.prj.dao.PrjDAO;
import com.kpms.prj.vo.PrjVO;

@Service
public class PrjServiceImpl implements PrjService {
	
	@Autowired
	private PrjDAO prjDAO;
	
	@Autowired
	private CmnCdDAO cmnCdDAO;

	@Override
	public List<PrjVO> readAllPrjVO(PrjVO prjVO) {
		return prjDAO.readAllPrjVO(prjVO);
	}
	
	@Override
	public List<PrjVO> readAllPrjVONoPagination(String prjNm) {
		return prjDAO.readAllPrjVONoPagination(prjNm);
	}
	
	@Override
	public PrjVO readOnePrjVOByPrjId(String prjId) {
		return prjDAO.readOnePrjVOByPrjId(prjId);
	}
	
	@Override
	public boolean createOnePrj(PrjVO prjVO) {
		
		if (StringUtil.isEmpty(prjVO.getPrjNm())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "프로젝트명은 필수 값입니다.");
		}

		if (StringUtil.isEmpty(prjVO.getCstmr())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "고객사명은 필수 값입니다.");
		}
		
		if (StringUtil.isEmpty(prjVO.getPrjStts())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "프로젝트 상태는 필수 값입니다.");
		}
		
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
