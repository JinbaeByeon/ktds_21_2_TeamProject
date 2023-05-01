package com.kpms.tm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.tm.dao.TmDAO;
import com.kpms.tm.vo.TmSearchVO;
import com.kpms.tm.vo.TmVO;
import com.kpms.tmmbr.dao.TmMbrDAO;

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
		tmMbrDAO.deleteTmMbrByTmId(tmVO.getTmId());
		boolean result = tmDAO.updateOneTm(tmVO) > 0;
		/*
		 * TmVO orgnTmVO = tmDAO.readOneTmVOByTmId(tmVO.getTmId()); if (result) { String
		 * hdTmMbrId = tmMbrDAO.readAllTmMbrVO(tmVO.getTmId()) .stream() .filter(vo ->
		 * vo.getEmpId().equals(orgnTmVO.getTmHdId())) .map(vo -> vo.getTmMbrId())
		 * .findFirst().orElse(null); String newTmHdId = tmVO.getTmHdId();
		 * 
		 * // 원래 팀장과 신규팀장이 같으면 delete 안하고 바뀌면 delete if (hdTmMbrId != null) { if
		 * (orgnTmVO.getTmHdId().equals(newTmHdId)) {
		 * 
		 * } else {
		 * 
		 * tmMbrDAO.deleteOneTmMbrByTmMbrId(hdTmMbrId); } } }
		 */
		return result; 
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
		else {
			throw new APIArgsException("400", "프로젝트를 진행중인 팀이 존재합니다.");
		}
		
		return delCount > 0;
	}

	@Override
	public boolean deleteTmBySelectedTmId(List<String> tmId) {
		int delCount = tmDAO.deleteTmBySelectedTmId(tmId);
		String tmInprj = "";
		for (String tm : tmDAO.readTmInPrj(tmId)) {
			tmInprj += tm;
		}
		boolean isSuccess = delCount == tmId.size();
		
		if (!isSuccess) {
			throw new APIException("400", "프로젝트를 진행중인 팀이 존재합니다." + tmInprj);
		}
		else {
			for (String tmid : tmId) {
				tmMbrDAO.deleteTmMbrByTmId(tmid);
			}
		}
		
		return isSuccess;
	}

}
