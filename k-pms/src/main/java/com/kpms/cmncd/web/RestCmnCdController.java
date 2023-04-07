package com.kpms.cmncd.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.cmncd.service.CmnCdService;
import com.kpms.cmncd.vo.CmnCdVO;
import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.vo.EmpVO;

@RestController
public class RestCmnCdController {
	
	@Autowired
	private CmnCdService cmnCdService;
	
	@PostMapping("/cmncd/create")
	public APIResponseVO doCreateCmnCd(CmnCdVO cmnCdVO, @SessionAttribute("__ADMIN__") EmpVO empVO) {
		cmnCdVO.setCrtr(empVO.getEmpId());
		cmnCdVO.setMdfyr(empVO.getEmpId());
		
		boolean createResult = cmnCdService.createOneCmnCd(cmnCdVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/cmncd/update/")
	public APIResponseVO doUpdateCmnCd(CmnCdVO cmnCdVO, @SessionAttribute("__ADMIN__") EmpVO empVO) {
		cmnCdVO.setMdfyr(empVO.getEmpId());
		
		boolean createResult = cmnCdService.updateOneCmnCd(cmnCdVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@GetMapping("/cmncd/delete/{cmnCdId}")
	public APIResponseVO doDeleteCmnCd(@PathVariable int cmnCdId) {
		boolean deleteResult = cmnCdService.deleteOneCmnCdByCdId(cmnCdId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

}
