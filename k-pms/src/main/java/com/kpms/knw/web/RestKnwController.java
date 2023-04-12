package com.kpms.knw.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.vo.EmpVO;
import com.kpms.knw.service.KnwService;
import com.kpms.knw.vo.KnwVO;

@RestController
public class RestKnwController {
	
	@Autowired
	private KnwService knwService;
	
	@PostMapping("api/knw/create")
	public APIResponseVO doCreateKnw(KnwVO knwVO, @SessionAttribute("__USER__") EmpVO empVO) {
		knwVO.setCrtr(empVO.getEmpId());
		knwVO.setMdfyr(empVO.getEmpId());
		
		boolean isSuccess = knwService.createOneKnw(knwVO);
		
		if(isSuccess) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
}
