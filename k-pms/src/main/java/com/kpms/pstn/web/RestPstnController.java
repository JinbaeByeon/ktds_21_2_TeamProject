package com.kpms.pstn.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.pstn.service.PstnService;
import com.kpms.pstn.vo.PstnVO;

@RestController
public class RestPstnController {

	@Autowired
	private PstnService pstnService;
	
	@PostMapping("/pstn/create")
	public APIResponseVO doCreatePstn(PstnVO pstnVO
			) {
		pstnVO.setCrtr("1");
		pstnVO.setMdfyr("1");
		
		boolean createResult = pstnService.createNewPstn(pstnVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	
	@PostMapping("/api/pstn/update")	
	public APIResponseVO doUpdatePstn(PstnVO pstnVO
			/*@SessionAttribute("__ADMIN__") EmpVO empVO*/) {
		
				/*
				 * pstnVO.setMdfyr(empVO.getEmpId());
				 */		
		pstnVO.setMdfyr("1");
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
