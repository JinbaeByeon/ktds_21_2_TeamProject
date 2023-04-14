package com.kpms.eqp.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.vo.EmpVO;
import com.kpms.eqp.service.EqpService;
import com.kpms.eqp.vo.EqpVO;

@RestController
public class RestEqpController {

	@Autowired
	private EqpService eqpService;
	
	@PostMapping("/api/eqp/create")
	public APIResponseVO doCreateEqp(EqpVO eqpVO,
									@SessionAttribute("__USER__") EmpVO empVO) {
		eqpVO.setCrtr(empVO.getEmpId());
		eqpVO.setMdfyr(empVO.getEmpId());
		
		boolean createResult = eqpService.createNewEqp(eqpVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	
	@PostMapping("/api/eqp/update")	
	public APIResponseVO doUpdateEqp(EqpVO eqpVO,
									  @SessionAttribute("__USER__") EmpVO empVO) {
		eqpVO.setMdfyr(empVO.getEmpId());
		
		boolean updateResult = eqpService.updateEqp(eqpVO);
		
		if(updateResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@GetMapping("/api/eqp/delete/{eqpId}")
	public APIResponseVO doDeleteEqp(@PathVariable String eqpId) {
		System.out.println(eqpId);
		boolean deleteResult = eqpService.deleteEqpByEqpId(eqpId);
		
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/eqp/delete")
	public APIResponseVO doDeleteEqpBySelectedEqpId(@RequestParam List<String> eqpId) {
		boolean deleteResult = eqpService.deleteEqpBySelectedEqpId(eqpId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	
}
