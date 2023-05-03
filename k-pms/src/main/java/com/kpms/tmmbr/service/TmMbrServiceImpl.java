package com.kpms.tmmbr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.tmmbr.dao.TmMbrDAO;
import com.kpms.tmmbr.vo.TmMbrVO;

@Service
public class TmMbrServiceImpl implements TmMbrService {
	
	@Autowired
	private TmMbrDAO tmMbrDAO;

	@Override
	public List<TmMbrVO> readAllTmMbrVO(String tmId) {
		return tmMbrDAO.readAllTmMbrVO(tmId);
	}
	
	@Override
	public List<TmMbrVO> readAllTmMbrInTm(String tmId) {
		return tmMbrDAO.readAllTmMbrInTm(tmId);
	}

	@Override
	public boolean createOneTmMbr(TmMbrVO tmMbrVO) {
		return tmMbrDAO.createOneTmMbr(tmMbrVO) > 0;
	}
	
	@Override
	public boolean deleteOneTmMbrByTmMbrId(String tmMbrId) {
		int delCount = tmMbrDAO.deleteOneTmMbrByTmMbrId(tmMbrId);
		if (delCount > 0) {
		}
		else {
			throw new APIArgsException("400", "프로젝트를 진행중인 팀원이 존재합니다.");
		}
		
		return delCount > 0;
	}

	@Override
	public boolean deleteTmMbrBySelectedTmMbrId(List<String> tmMbrId) {
		int delCount = tmMbrDAO.deleteTmMbrBySelectedTmMbrId(tmMbrId);
		boolean isSuccess = delCount == tmMbrId.size();
		
		if (!isSuccess) {
			throw new APIException("400", "프로젝트를 진행중인 팀원이 존재합니다.");
		}
		
		return isSuccess;
	}


}
