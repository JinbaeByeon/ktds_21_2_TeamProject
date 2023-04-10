package com.kpms.prj.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.prj.service.PrjService;
import com.kpms.prj.vo.PrjVO;

@RestController
public class RestPrjController {
	
	@Autowired
	private PrjService prjService;
	
	@PostMapping("/api/prj/create")
	public APIResponseVO doCreatePrj(PrjVO prjVO) {
		
		prjVO.setCrtr("");
		prjVO.setMdfyr("");
		
		String prjNm = prjVO.getPrjNm();
		if (prjNm == null || prjNm.trim().length() == 0) {
			throw new APIArgsException("400", "프로젝트명이 없습니다.");
		}
		
		boolean createResult = prjService.createOnePrj(prjVO);
		if (createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "프로젝트 등록 실패", "");
		}
	}
}
