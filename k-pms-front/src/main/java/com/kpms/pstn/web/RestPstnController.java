package com.kpms.pstn.web;

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
import com.kpms.pstn.service.PstnService;
import com.kpms.pstn.vo.PstnVO;

@RestController
public class RestPstnController {

	@Autowired
	private PstnService pstnService;
	
	@PostMapping("/api/pstn/create")
	public APIResponseVO doCreatePstn(PstnVO pstnVO,
			   						   @SessionAttribute("__USER__") EmpVO empVO) {
		pstnVO.setCrtr(empVO.getEmpId());
		pstnVO.setMdfyr(empVO.getEmpId());
		pstnVO.setMdfyr(empVO.getEmpId());
		boolean createResult = pstnService.createNewPstn(pstnVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	
	@PostMapping("/api/pstn/update")	
	public APIResponseVO doUpdatePstn(PstnVO pstnVO,
									   @SessionAttribute("__USER__") EmpVO empVO) {
		pstnVO.setMdfyr(empVO.getEmpId());
				 	
		boolean updateResult = pstnService.updateNewPstn(pstnVO);
		
		if(updateResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@GetMapping("/api/pstn/delete/{pstnId}")
	public APIResponseVO doDeletePstn(@PathVariable int pstnId) {
		boolean deleteResult = pstnService.deletePstnByPstnId(pstnId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/pstn/delete")
	public APIResponseVO doDeletePstnBySelectedPstnId(@RequestParam List<Integer> pstnId) {
		boolean deleteResult = pstnService.deletePstnBySelectedPstnId(pstnId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	
}
