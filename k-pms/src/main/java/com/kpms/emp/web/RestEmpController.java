package com.kpms.emp.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIException;
import com.kpms.emp.service.EmpService;
import com.kpms.emp.vo.EmpVO;
import com.kpms.lgnhst.vo.LgnHstVO;

@RestController
public class RestEmpController {

	@Autowired
	private EmpService empService;

	@PostMapping("/api/emp/lgn")
	public APIResponseVO doLoginEmp(EmpVO empVO, HttpServletRequest request, HttpSession session) {
		EmpVO user =  empService.readOneEmpByIdAndPwd(empVO);
		if(user == null) {
			throw new APIException(APIStatus.DISMATCH, "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
		session.setAttribute("__USER__", user);
		LgnHstVO lgnHst = new LgnHstVO();
		lgnHst.setAct("login");
		lgnHst.setCrtr(user.getEmpId());
		lgnHst.setIp(request.getRemoteAddr());
		empService.createLgnHst(lgnHst);
		
		return new APIResponseVO(APIStatus.OK,"/index");

	}
	
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
