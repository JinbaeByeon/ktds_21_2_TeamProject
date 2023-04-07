package com.kpms.dep.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
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
		
		boolean createResult = depService.createOneDep(depVO);
		
		if (createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
}
