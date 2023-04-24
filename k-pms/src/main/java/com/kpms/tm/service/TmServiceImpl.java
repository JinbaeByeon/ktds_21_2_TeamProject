package com.kpms.tm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.tm.dao.TmDAO;
import com.kpms.tm.vo.TmSearchVO;
import com.kpms.tm.vo.TmVO;
import com.kpms.tmmbr.dao.TmMbrDAO;
import com.kpms.tmmbr.vo.TmMbrVO;

@Service
public class TmServiceImpl implements TmService {

	@Autowired
	private TmDAO tmDAO;
	
	@Autowired
	private TmMbrDAO tmMbrDAO;

	@Override
	public List<TmVO> readAllTmVO(TmSearchVO tmSearchVO) {
		return tmDAO.readAllTmVO(tmSearchVO);
	}

	@Override
	public List<TmVO> readAllTmVONopagination(String depId) {
		return tmDAO.readAllTmVONopagination(depId);
	}

	@Override
	public TmVO readOneTmVOByTmId(String tmId) {
		return tmDAO.readOneTmVOByTmId(tmId);
	}

	@Override
	public boolean createOneTm(TmVO tmVO) {
		
		if (tmVO.getDepId() == null || tmVO.getDepId().trim().length() == 0) {
			throw new APIArgsException("400", "부서아이디가 누락되었습니다.");
		}
		if (tmVO.getTmNm() == null || tmVO.getTmNm().trim().length() == 0) {
			throw new APIArgsException("400", "팀명이 누락되었습니다.");
		}
		if (tmVO.getTmHdId() == null || tmVO.getTmHdId().trim().length() == 0) {
			throw new APIArgsException("400", "팀장이 누락되었습니다.");
		}
		if (tmVO.getTmCrtDt() == null || tmVO.getTmCrtDt().trim().length() == 0) {
			throw new APIArgsException("400", "팀생성일이 누락되었습니다.");
		}
		
		return tmDAO.createOneTm(tmVO) > 0;
	}

	@Override
	public boolean updateOneTm(TmVO tmVO) {
		return tmDAO.updateOneTm(tmVO) > 0; 
	}


	@Override
	public boolean updateOneTmAndTmMbr(TmVO tmVO) {
		return tmDAO.updateOneTmAndTmMbr(tmVO) > 0;
	}
	
	@Override
	public boolean deleteOneTmByTmId(String tmId) {
		int delCount = tmDAO.deleteOneTmByTmId(tmId);
		if (delCount > 0) {
			tmMbrDAO.deleteTmMbrByTmId(tmId);
		}
		
		return delCount > 0;
	}

	@Override
	public boolean deleteTmBySelectedTmId(List<String> tmId) {
		int delCount = tmDAO.deleteTmBySelectedTmId(tmId);
		boolean isSuccess = delCount == tmId.size();
		
		if (!isSuccess) {
			throw new APIException("500", "삭제에 실패했습니다. 요청건수:("+tmId.size() +"건), 삭제건수:("+delCount+"건)");
		}
		
		return isSuccess;
	}

}
