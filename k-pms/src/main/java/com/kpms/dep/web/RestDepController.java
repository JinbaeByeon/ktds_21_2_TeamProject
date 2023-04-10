package com.kpms.dep.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.dep.service.DepService;
import com.kpms.dep.vo.DepVO;
import com.kpms.emp.vo.EmpVO;

@RestController
public class RestDepController {

	@Autowired
	private DepService depService;
	
	@PostMapping("/api/dep/create")
	public APIResponseVO doCreateDep(DepVO depVO,
			@SessionAttribute("__USER__") EmpVO empVO) {
		
		depVO.setCrtr(empVO.getEmpId());
		depVO.setMdfyr(empVO.getEmpId());
		
		String depNm = depVO.getDepNm();
		
		if (depNm == null || depNm.trim().length() == 0) {
			throw new APIArgsException("400", "부서명이 누락되었습니다.");
		}
		
		boolean createResult = depService.createOneDep(depVO);
		
		if (createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "부서를 등록할 수 없습니다.", "500", "");
		}
	}
	
	@PostMapping("/api/dep/update")
	public APIResponseVO doUpadateDep(DepVO depVO, 
				@SessionAttribute("__USER__") EmpVO empVO) {
		depVO.setCrtr(empVO.getEmpId());
		depVO.setMdfyr(empVO.getEmpId());

		String depNm = depVO.getDepNm();
		
		if (depNm == null || depNm.trim().length() == 0) {
			throw new APIArgsException("400", "부서명이 누락되었습니다.");
		}
		
		boolean updateResult = depService.updateOneDepByDepId(depVO);
		
		if (updateResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "부서를 수정할 수 없습니다.", "500", "");
		}
	}
	
	@GetMapping("/api/dep/delete/{depId}")
	public APIResponseVO doDeleteDep(@PathVariable String depId) {
		boolean deleteResult = depService.deleteOneDepByDepId(depId);
		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "부서를 삭제할 수 없습니다.", "500", "");
		}
	}
}