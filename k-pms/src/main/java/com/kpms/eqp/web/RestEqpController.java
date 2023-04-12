package com.kpms.eqp.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.eqp.service.EqpService;
import com.kpms.pstn.vo.PstnVO;

@RestController
public class RestEqpController {

	@Autowired
	private EqpService eqpService;
	
	@PostMapping("/eqp/create")
	public APIResponseVO doCreateEqp(EqpVO eqpVO
			) {
		eqpVO.setCrtr("1");
		eqpVO.setMdfyr("1");
		
		boolean createResult = eqpService.createNewEqp(eqpVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	
	@PostMapping("/api/eqp/update")	
	public APIResponseVO doUpdatePstn(PstnVO eqpVO
			/*@SessionAttribute("__ADMIN__") EmpVO empVO*/) {
		
				/*
				 * pstnVO.setMdfyr(empVO.getEmpId());
				 */		
		eqpVO.setMdfyr("1");
		boolean updateResult = eqpService.updateNewPstn(eqpVO);
		
		if(updateResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@GetMapping("/api/eqp/delete/{eqpId}")
	public APIResponseVO doDeleteEqp(@PathVariable String eqpId) {
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
