package com.kpms.eqplog.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.vo.EmpVO;
import com.kpms.eqplog.service.EqpLogService;
import com.kpms.eqplog.vo.EqpLogVO;

@RestController
public class RestEqpLogController {
	
	@Autowired
	private EqpLogService eqpLogService;
	
	@PostMapping("/api/eqplog/create")
	public APIResponseVO doCreateEqpLog(EqpLogVO eqpLogVO,
										 @SessionAttribute("__USER__") EmpVO empVO) {
		eqpLogVO.setCrtr(empVO.getEmpId());
		eqpLogVO.setMdfyr(empVO.getEmpId());
		
		boolean createResult = eqpLogService.createEqpLog(eqpLogVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
}
