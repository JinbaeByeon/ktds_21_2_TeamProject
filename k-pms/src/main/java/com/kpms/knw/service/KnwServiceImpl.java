package com.kpms.knw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.atchfl.dao.AtchFlDAO;
import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.common.handler.UploadHandler;
import com.kpms.common.util.StringUtil;
import com.kpms.knw.dao.KnwDAO;
import com.kpms.knw.vo.KnwSearchVO;
import com.kpms.knw.vo.KnwVO;

@Service
public class KnwServiceImpl implements KnwService {

	@Autowired
	private KnwDAO knwDAO;
	@Autowired
	private AtchFlDAO atchFlDAO;
	@Autowired
	UploadHandler uploadHandler;

	@Override
	public boolean createOneKnw(KnwVO knwVO) {

		if (StringUtil.isEmpty(knwVO.getTtl())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "제목은 필수값입니다.");
		}
		if (StringUtil.isEmpty(knwVO.getCntnt())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "내용은 필수값입니다.");
		}
		if (StringUtil.isEmpty(knwVO.getPrjId())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "프로젝트 선택은 필수입니다.");
		}

		boolean isSuccess = knwDAO.createOneKnw(knwVO) > 0;

		List<AtchFlVO> fileList = knwVO.getAtchFlList();

		if (!fileList.isEmpty()) {
			fileList.forEach(file -> {
				file.setCrtr(knwVO.getCrtr());
				file.setFrgnId(knwVO.getKnwId());
			});
			if (atchFlDAO.createNewAtchFls(fileList) == 0) {
				return false;
			}
			return true;
		}

		return isSuccess;
	}

	@Override
	public List<KnwVO> readAllKnw(KnwSearchVO knwSearchVO) {
		return knwDAO.readAllKnw(knwSearchVO);
	}

	@Override
	public KnwVO readOneKnwByKnwId(String KnwId) {
		return knwDAO.readOneKnwByKnwId(KnwId);
	}

	@Override
	public boolean updateOneKnw(KnwVO knwVO) {

		if (StringUtil.isEmpty(knwVO.getTtl())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "제목은 필수값입니다.");
		}
		if (StringUtil.isEmpty(knwVO.getCntnt())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "내용은 필수값입니다.");
		}
		if (StringUtil.isEmpty(knwVO.getPrjId())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "프로젝트 선택은 필수입니다.");
		}

		boolean isSuccess = knwDAO.updateOneKnw(knwVO) > 0;
		atchFlDAO.deleteAtchFlsByFrgnId(knwVO.getKnwId());
		
		List<AtchFlVO> fileList = knwVO.getAtchFlList();
		
		if (!fileList.isEmpty()) {
			fileList.forEach(file -> {
				file.setCrtr(knwVO.getMdfyr());
				file.setFrgnId(knwVO.getKnwId());
			});
			if (atchFlDAO.createNewAtchFls(fileList) == 0) {
				return false;
			}
			return true;
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
