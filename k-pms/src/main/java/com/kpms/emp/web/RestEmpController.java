package com.kpms.emp.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.util.StringUtil;
import com.kpms.emp.service.EmpService;
import com.kpms.emp.vo.EmpVO;

@RestController
public class RestEmpController {

	@Autowired
	private EmpService empService;
	
	@PostMapping("/")
	public APIResponseVO doCreateEmp(EmpVO empVO,String cPwd) {

		if(StringUtil.isEmpty(empVO.getfNm())) {
			throw new APIArgsException("404", "이름은 필수 값입니다.");
		}
		if(StringUtil.isEmpty(empVO.getEmpId())) {
			throw new APIArgsException("404", "ID는 필수 값입니다.");
		}
		if(StringUtil.isEmpty(empVO.getEml())) {
			throw new APIArgsException("404", "이메일은 필수 값입니다.");
		}
		if(StringUtil.isEmpty(empVO.getPwd())) {
			throw new APIArgsException("404", "비밀번호는 필수 값입니다.");
		}
		
		if(empService.createOneEmp(empVO)) {
			return new APIResponseVO(APIStatus.OK);
		}
		return new APIResponseVO(APIStatus.FAIL);
	}
}
