package com.kpms.tmmbr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public boolean createOneTmMbr(TmMbrVO tmMbrVO) {
		return tmMbrDAO.createOneTmMbr(tmMbrVO) > 0;
	}
	
	@Override
	public boolean deleteOneTmMbrByTmMbrId(String tmMbrId) {
		return tmMbrDAO.deleteOneTmMbrByTmMbrId(tmMbrId) > 0;
	}

	@Override
	public boolean deleteTmMbrBySelectedTmMbrId(List<String> tmMbrId) {
		int delCount = tmMbrDAO.deleteTmMbrBySelectedTmMbrId(tmMbrId);
		boolean isSuccess = delCount == tmMbrId.size();
		
		if (!isSuccess) {
			throw new APIException("500", "삭제에 실패했습니다. 요청건수:("+tmMbrId.size() +"건), 삭제건수:("+delCount+"건)");
		}
		
		return isSuccess;
	}



}
