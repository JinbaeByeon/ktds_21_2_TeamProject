package com.kpms.emp.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.emp.service.EmpService;
import com.kpms.emp.vo.EmpVO;

@RestController
public class RestEmpController {

	@Autowired
	private EmpService empService;

	@PostMapping("/api/emp/lgn")
	public APIResponseVO doLoginEmp(EmpVO empVO, HttpServletRequest request, HttpSession session) {
		empVO.setLtstLgnIp(request.getRemoteAddr());
		EmpVO user =  empService.readOneEmpByIdAndPwd(empVO);
		if(user == null) {
			throw new APIException(APIStatus.DISMATCH, "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		session.setAttribute("__USER__", user);
		
		
		
		return new APIResponseVO(APIStatus.OK,"/index");

	}
	
	@PostMapping("/api/emp/rgst")
	public APIResponseVO doRegistEmp(EmpVO empVO, @SessionAttribute("__USER__") EmpVO user) {
		
		if(empVO.getDepId()==null) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "부서를 입력하세요.");
		}
		
		empVO.setCrtr(user.getEmpId());
		empVO.setMdfyr(user.getEmpId());
		if (empService.createOneEmp(empVO)) {
			return new APIResponseVO(APIStatus.OK,"/emp/list");
		}
		return new APIResponseVO(APIStatus.FAIL,"사원 등록 실패","왜실패햇지","");
	}
	

}
