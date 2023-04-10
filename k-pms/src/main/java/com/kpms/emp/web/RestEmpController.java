package com.kpms.emp.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.service.EmpService;
import com.kpms.emp.vo.EmpVO;

@RestController
public class RestEmpController {

	@Autowired
	private EmpService empService;
	
	@PostMapping("/api/emp/rgst")
	public APIResponseVO doRegistEmp(EmpVO empVO,String cPwd) {

		empVO.setCrtr(empVO.getEmpId());
		empVO.setMdfyr(empVO.getEmpId());
		if (empService.createOneEmp(empVO, cPwd)) {
			return new APIResponseVO(APIStatus.OK,"/");
		}
		return new APIResponseVO(APIStatus.FAIL);

	}
}
