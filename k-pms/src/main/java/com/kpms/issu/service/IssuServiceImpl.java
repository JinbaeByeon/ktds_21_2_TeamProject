package com.kpms.issu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.atchfl.dao.AtchFlDAO;
import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIException;
import com.kpms.issu.dao.IssuDAO;
import com.kpms.issu.vo.IssuVO;

@Service
public class IssuServiceImpl implements IssuService {

	@Autowired
	private IssuDAO issuDAO;
	@Autowired
	private AtchFlDAO atchFlDAO;
	
	@Override
	public boolean createOneIssu(IssuVO issuVO) {
		if(issuDAO.createOneIssu(issuVO)==0) {
			return false;
		}
		List<AtchFlVO> fileList = issuVO.getAtchFlList();
		if(fileList != null && !fileList.isEmpty()) {
			fileList.forEach(file-> {
				file.setCrtr(issuVO.getCrtr());
				file.setFrgnId(issuVO.getIssuId());
			});
			if (atchFlDAO.createNewAtchFls(fileList) != fileList.size()) {
				throw new APIException(APIStatus.FAIL, "파일 첨부를 실패했습니다.");
			}
		}
		return true;
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
		List<AtchFlVO> fileList = issuVO.getAtchFlList();
		atchFlDAO.deleteAtchFlsByFrgnId(issuVO.getIssuId());
		
		if(fileList != null && !fileList.isEmpty()) {
			fileList.forEach(file-> {
				file.setCrtr(issuVO.getMdfyr());
				file.setFrgnId(issuVO.getIssuId());
			});
			if (atchFlDAO.createNewAtchFls(fileList) != fileList.size()) {
				throw new APIException(APIStatus.FAIL, "파일 첨부를 실패했습니다.");
			}
		}
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
