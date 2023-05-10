package com.kpms.tm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.common.util.StringUtil;
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
		
		int tmCreateCount = tmDAO.createOneTm(tmVO);
		if (tmCreateCount > 0) {
			List<TmMbrVO> tmMbrList = tmVO.getTmMbrList();
			if (tmMbrList == null || tmMbrList.isEmpty()) {
				throw new APIArgsException("404", "팀원을 선택하세요");
			}
			for (TmMbrVO tmMbr: tmMbrList) {
				tmMbr.setTmId(tmVO.getTmId());
				tmMbr.setCrtr(tmVO.getCrtr());
				tmMbr.setMdfyr(tmVO.getMdfyr());
				tmMbrDAO.createOneTmMbr(tmMbr);
			}
		}
		return tmCreateCount > 0;
	}

	@Override
	public boolean updateOneTm(TmVO tmVO) {
	    if (tmVO.getTmNm() == null || tmVO.getTmNm().trim().length() == 0) {
	        throw new APIArgsException("", "팀명이 누락되었습니다.");
	    }
	    if (tmVO.getTmHdId() == null || tmVO.getTmHdId().trim().length() == 0) {
	        throw new APIArgsException("", "팀장이 누락되었습니다.");
	    }
	    if (tmVO.getTmCrtDt() == null || tmVO.getTmCrtDt().trim().length() == 0) {
	        throw new APIArgsException("", "팀생성일이 누락되었습니다.");
	    }
	    
	    TmVO orgnTmVO = tmDAO.readOneTmVOByTmId(tmVO.getTmId());
	    String hdTmMbrId = tmMbrDAO.readAllTmMbrVO(tmVO.getTmId())
	    		.stream()
	    		.filter(vo -> vo.getEmpId().equals(orgnTmVO.getTmHdId()))
	    		.map(vo -> vo.getTmMbrId())
	    		.findFirst()
	    		.orElse(null);
	    
	    boolean result = tmDAO.updateOneTm(tmVO) > 0;
	    
	    if (result) {
	        List<TmMbrVO> tmMbrList = tmVO.getTmMbrList();
	        if (tmMbrList != null) {
	        	
	        	boolean isThBeforeMbr = orgnTmVO.getTmMbrList().stream()
	                    .anyMatch(tmMbr -> tmMbr.getEmpId().equals(tmVO.getTmHdId()));
	        	
		        for (TmMbrVO tmMbr: tmMbrList) {
		        	
		        	if (isThBeforeMbr && tmMbr.getEmpId().equals(tmVO.getTmHdId())) {
		                   continue;
		            }
		        	
		            tmMbr.setTmId(tmVO.getTmId());
		            tmMbr.setCrtr(tmVO.getCrtr());
		            tmMbr.setMdfyr(tmVO.getMdfyr());
		            tmMbrDAO.createOneTmMbr(tmMbr);
		        }
	        }
	        
	        String newTmHdId = tmVO.getTmHdId();
	        System.out.println(hdTmMbrId + "  " + newTmHdId);
	         
	        if (hdTmMbrId != null) { 
	            if (orgnTmVO.getTmHdId().equals(newTmHdId)) {
	            }
	            else {
	            	tmMbrDAO.deleteTmMbrByTmMbrId(hdTmMbrId);
	            }
	        } 
	    } 
	    return result; 
	}

	@Override
	public boolean updateOneTmAndTmMbr(TmVO tmVO) {
		int tmMbrUpdateCount = tmDAO.updateOneTmAndTmMbr(tmVO);
		if (tmMbrUpdateCount > 0) {
		   List<TmMbrVO> tmMbrList = tmVO.getTmMbrList();
	        if (tmMbrList != null) {
		        for (TmMbrVO tmMbr: tmMbrList) {
		            tmMbr.setTmId(tmVO.getTmId());
		            tmMbr.setCrtr(tmVO.getCrtr());
		            tmMbr.setMdfyr(tmVO.getMdfyr());
		            tmMbrDAO.createOneTmMbr(tmMbr);
		        }
	        }
		}
		return tmMbrUpdateCount > 0;
	}
	
	@Override
	public boolean deleteOneTmByTmId(String tmId) {
		int delCount = tmDAO.deleteOneTmByTmId(tmId);
		
		if (delCount > 0) {
			tmMbrDAO.deleteTmMbrByTmId(tmId);
		}
		else {
			throw new APIArgsException("", "프로젝트를 진행중인 팀이 존재합니다.");
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
			throw new APIException("", "프로젝트를 진행중인 팀이 존재합니다." + tmInprj);
		}
		else {
			for (String tmid : tmId) {
				tmMbrDAO.deleteTmMbrByTmId(tmid);
			}
		}
		
		return isSuccess;
	}

}
