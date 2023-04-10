package com.kpms.emp.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.emp.service.EmpService;
import com.kpms.emp.vo.EmpVO;

@RestController
public class RestEmpController {

	@Autowired
	private EmpService empService;
	
	@PostMapping("/api/emp/lgn")
	public APIResponseVO doRegistEmp(EmpVO empVO,String cPwd) {
		return new APIResponseVO("","","","/emp/list");
		/*
		 * if(StringUtil.isEmpty(empVO.getfNm())) { throw new
		 * APIArgsException(APIStatus.MISSING_ARG, "이름은 필수 값입니다."); }
		 * if(StringUtil.isEmpty(empVO.getEmpId())) { throw new
		 * APIArgsException(APIStatus.MISSING_ARG, "ID는 필수 값입니다."); }
		 * if(StringUtil.isEmpty(empVO.getEml())) { throw new
		 * APIArgsException(APIStatus.MISSING_ARG, "이메일은 필수 값입니다."); }
		 * if(StringUtil.isEmpty(empVO.getPwd())) { throw new
		 * APIArgsException(APIStatus.MISSING_ARG, "비밀번호는 필수 값입니다."); }
		 * if(StringUtil.isExceedLength(empVO.getfNm(), 30)) { throw new
		 * APIArgsException(APIStatus.OVER_LEN_ARG, "이름은 30글자까지 입력할 수 있습니다."); }
		 * if(StringUtil.isExceedLength(empVO.getlNm(), 10)) { throw new
		 * APIArgsException(APIStatus.OVER_LEN_ARG, "성은 10글자까지 입력할 수 있습니다."); }
		 * if(StringUtil.isExceedLength(empVO.getEmpId(), 10)) { throw new
		 * APIArgsException(APIStatus.OVER_LEN_ARG, "ID는 10글자까지 입력할 수 있습니다."); }
		 * if(StringUtil.isExceedLength(empVO.getEml(), 50)) { throw new
		 * APIArgsException(APIStatus.OVER_LEN_ARG, "이메일은 50글자까지 입력할 수 있습니다."); } //핸드폰
		 * //주소 //생년월일
		 * 
		 * if(StringUtil.isMatchTo(empVO.getPwd(), cPwd)) { throw new
		 * APIArgsException(APIStatus.INCORRECT, "비밀번호가 일치하지 않습니다."); }
		 * 
		 * if(empService.createOneEmp(empVO)) { return new APIResponseVO(APIStatus.OK);
		 * } return new APIResponseVO(APIStatus.FAIL);
		 */
	}
}
