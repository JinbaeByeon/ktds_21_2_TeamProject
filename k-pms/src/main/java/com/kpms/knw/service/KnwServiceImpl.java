package com.kpms.knw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.knw.dao.KnwDAO;
import com.kpms.knw.vo.KnwVO;

@Service
public class KnwServiceImpl implements KnwService {

	@Autowired
	private KnwDAO knwDAO;

	@Override
	public boolean createOneKnw(KnwVO knwVO) {
		boolean isSuccess = knwDAO.createOneKnw(knwVO) > 0;

		if (!isSuccess) {
			throw new APIArgsException("400", "제목과 내용은 필수값입니다.");
		}

		return isSuccess;
	}

	@Override
	public List<KnwVO> readAllKnw(KnwVO knwVO) {
		return knwDAO.readAllKnw(knwVO);
	}
	
	@Override
	public KnwVO readOneKnwByKnwId(String KnwId) {
		return knwDAO.readOneKnwByKnwId(KnwId);
	}

	@Override
	public boolean updateOneKnw(KnwVO knwVO) {
		boolean isSuccess = knwDAO.updateOneKnw(knwVO) > 0;

		if (!isSuccess) {
			throw new APIArgsException("400", "제목과 내용은 필수값입니다.");
		}

		return isSuccess;
	}

	@Override
	public boolean deleteOneKnw(String knwId) {
		return knwDAO.deleteOneKnw(knwId) > 0;
	}

	@Override
	public boolean deleteKnwBySelectedKnwId(List<String> knwIdList) {
		int delCount = knwDAO.deleteKnwBySelectedKnwId(knwIdList);
		boolean isSuccess = (delCount == knwIdList.size());

		if (!isSuccess) {
			throw new APIException("500", "삭제에 실패했습니다. 요청 건수: (" + knwIdList.size() + "건), 삭제건수 (" + delCount + "건)");
		}

		return isSuccess;
	}

}
