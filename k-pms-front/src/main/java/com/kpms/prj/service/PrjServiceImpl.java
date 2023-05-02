package com.kpms.prj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.common.util.StringUtil;
import com.kpms.knw.dao.KnwDAO;
import com.kpms.prj.dao.PrjDAO;
import com.kpms.prj.vo.PrjSearchVO;
import com.kpms.prj.vo.PrjVO;
import com.kpms.prjtmmbr.dao.PrjTmMbrDAO;
import com.kpms.prjtmmbr.vo.PrjTmMbrVO;
import com.kpms.req.dao.ReqDAO;

@Service
public class PrjServiceImpl implements PrjService {

	@Autowired
	private PrjDAO prjDAO;

	@Autowired
	private PrjTmMbrDAO prjTmMbrDAO;
	
	@Autowired
	private ReqDAO reqDAO;
	
	@Autowired
	private KnwDAO knwDAO;

	@Override
	public List<PrjVO> readAllPrjVO(PrjSearchVO prjSearchVO) {
		return prjDAO.readAllPrjVO(prjSearchVO);
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

		if (StringUtil.isEmpty(prjVO.getStrtDt())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "시작일은 필수 값입니다.");
		}

		if (StringUtil.isEmpty(prjVO.getEndDt())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "종료일은 필수 값입니다.");
		}

		if (StringUtil.isEmpty(prjVO.getPrjStts())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "프로젝트 상태는 필수 값입니다.");
		}

		if (prjVO.getPtmList() == null || prjVO.getPtmList().isEmpty()) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "팀원은 필수 값입니다.");
		}

		int prjCreateCount = prjDAO.createOnePrj(prjVO);
		if (prjCreateCount > 0) {
			List<PrjTmMbrVO> ptmList = prjVO.getPtmList();
			if (ptmList == null || ptmList.isEmpty()) {
				throw new APIArgsException("404", "팀원을 추가해주세요");
			}
			for (PrjTmMbrVO ptm : ptmList) {
				if (StringUtil.isNull(ptm.getTmMbrId())) {
					continue;
				}
				ptm.setPrjId(prjVO.getPrjId());
				ptm.setCrtr(prjVO.getCrtr());
				ptm.setMdfyr(prjVO.getMdfyr());
				prjTmMbrDAO.createNewPrjTmMbr(ptm);
			}
		}
		return prjCreateCount > 0;
	}

	@Override
	public boolean updateOnePrj(PrjVO prjVO) {
		if (StringUtil.isEmpty(prjVO.getPrjNm())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "프로젝트명은 필수 값입니다.");
		}

		if (StringUtil.isEmpty(prjVO.getCstmr())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "고객사명은 필수 값입니다.");
		}

		if (StringUtil.isEmpty(prjVO.getStrtDt())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "시작일은 필수 값입니다.");
		}

		if (StringUtil.isEmpty(prjVO.getEndDt())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "종료일은 필수 값입니다.");
		}

		if (StringUtil.isEmpty(prjVO.getPrjStts())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "프로젝트 상태는 필수 값입니다.");
		}

		if (prjVO.getPtmList() == null || prjVO.getPtmList().isEmpty()) {
			 throw new APIArgsException(APIStatus.MISSING_ARG, "팀원은 필수 값입니다.");
		}
		 
		int prjUpdateCount = prjDAO.updateOnePrj(prjVO);
		if (prjUpdateCount > 0) {
			List<PrjTmMbrVO> ptmList = prjVO.getPtmList();
			if (ptmList == null || ptmList.isEmpty()) {
				throw new APIArgsException("404", "팀원을 추가해주세요");
			}
			for (PrjTmMbrVO ptm : ptmList) {
				if (ptm.getAdded() != null && ptm.getAdded().equals("true")) {
					if (StringUtil.isNull(ptm.getTmMbrId())) {
						continue;
					}
					ptm.setPrjId(prjVO.getPrjId());
					ptm.setCrtr(prjVO.getCrtr());
					ptm.setMdfyr(prjVO.getMdfyr());
					prjTmMbrDAO.createNewPrjTmMbr(ptm);
				}
				else if (ptm.getModified() != null && ptm.getModified().length() > 0) {
					if (StringUtil.isNull(ptm.getTmMbrId())) {
						continue;
					}
					ptm.setPrjTmMbrId(ptm.getModified());
					prjTmMbrDAO.updateOnePrjTmMbr(ptm);
				}
				else if (ptm.getDeleted() != null && ptm.getDeleted().length() > 0) {
					
					prjTmMbrDAO.deleteOnePrjTmMbrByPrjTmMbrId(ptm.getDeleted());
				}
			}
		}
		 
		return prjUpdateCount > 0;
	}

	@Override
	public boolean deleteOnePrjByPrjId(String prjId) {
		int prjDeleteCount = prjDAO.deleteOnePrjByPrjId(prjId);
		if (prjDeleteCount > 0) {
			prjTmMbrDAO.deletePrjTmMbrByPrjId(prjId);
			reqDAO.deleteReqByPrjId(prjId);
			knwDAO.deleteKnwByPrjId(prjId);
		}
		return prjDeleteCount > 0;
	}

	@Override
	public boolean deletePrjByPrjList(List<String> prjIdList) {
		boolean isSuccess = prjDAO.deletePrjByPrjList(prjIdList) == prjIdList.size();
		if (!isSuccess) {
			throw new APIException("500", "삭제실패");
		}
		else {
			for (String prjId: prjIdList) {
				prjTmMbrDAO.deletePrjTmMbrByPrjId(prjId);
				reqDAO.deleteReqByPrjId(prjId);
			}
		}
		return isSuccess;
	}

}
