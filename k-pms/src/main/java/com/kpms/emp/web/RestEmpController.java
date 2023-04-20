package com.kpms.emp.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.common.handler.SessionHandler;
import com.kpms.common.util.SHA256Util;
import com.kpms.common.util.StringUtil;
import com.kpms.emp.service.EmpService;
import com.kpms.emp.vo.EmpPwdVO;
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
		SessionHandler.get().setSession(user.getEmpId(), session);
		
		if(empService.readPwdChngDtMore90ById(empVO.getEmpId())) {
			return new APIResponseVO(APIStatus.OK,"pwdChng","/index");
		}
		return new APIResponseVO(APIStatus.OK,"/index");

	}
	
	@PostMapping("/api/emp/rgst")
	public APIResponseVO doRegistEmp(EmpVO empVO
			, @SessionAttribute("__USER__") EmpVO user
			, String admnPwd
			, MultipartFile uploadFile) {
		String empId = user.getEmpId();
		String salt = empService.readSaltById(empId);
		admnPwd = SHA256Util.getEncrypt(admnPwd, salt);
		if(!StringUtil.isMatchTo(admnPwd, user.getPwd())) {
			throw new APIArgsException(APIStatus.DISMATCH, "관리자 비밀번호가 일치하지 않습니다.");
		}
		if(empVO.getDepId()==null) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "부서를 입력하세요.");
		}
		if(empVO.getJobId()==0) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "직무를 입력하세요.");
		}
		if(empVO.getPstnId()==0) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "직급을 입력하세요.");
		}
		
		empVO.setCrtr(empId);
		empVO.setMdfyr(empId);
		if (empService.createOneEmp(empVO,uploadFile)) {
			return new APIResponseVO(APIStatus.OK,"/emp/list");
		}
		return new APIResponseVO(APIStatus.FAIL,"사원 등록 실패","왜실패햇지","");
	}

	@PostMapping("/api/emp/update")
	public APIResponseVO doUpdateEmp(EmpVO empVO
			, @SessionAttribute("__USER__") EmpVO user
			, String admnPwd
			, MultipartFile uploadFile) {
		String empId = user.getEmpId();
		String salt = empService.readSaltById(empId);
		admnPwd = SHA256Util.getEncrypt(admnPwd, salt);
		if(!StringUtil.isMatchTo(admnPwd, user.getPwd())) {
			throw new APIArgsException(APIStatus.DISMATCH, "관리자 비밀번호가 일치하지 않습니다.");
		}
		
		empVO.setMdfyr(user.getEmpId());
		if (empService.updateOneEmp(empVO,uploadFile)) {
			return new APIResponseVO(APIStatus.OK,"/emp/list");
		}
		return new APIResponseVO(APIStatus.FAIL,"사원 수정 실패","");
	}
	
	@PostMapping("/api/emp/update/password")
	public APIResponseVO doUpdatePwdEmp(EmpPwdVO empPwdVO) {
		if(empService.updateEmpPwd(empPwdVO)) {
			return new APIResponseVO(APIStatus.OK);
		}

		return new APIResponseVO(APIStatus.FAIL,"비밀번호 변경 실패","");
	}
	

	@GetMapping("/api/emp/reset/password")
	public APIResponseVO doResetPwdEmp(String empId, @SessionAttribute("__USER__") EmpVO user) {
		EmpVO empVO = new EmpVO();
		empVO.setEmpId(empId);
		empVO.setMdfyr(user.getEmpId());
		
		if(empService.updateEmpPwdReset(empVO)) {
			return new APIResponseVO(APIStatus.OK);
		}

		return new APIResponseVO(APIStatus.FAIL,"비밀번호 변경 실패","");
	}
}
