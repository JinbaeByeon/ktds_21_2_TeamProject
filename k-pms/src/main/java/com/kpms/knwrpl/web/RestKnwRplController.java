package com.kpms.knwrpl.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.vo.EmpVO;
import com.kpms.knwrpl.service.KnwRplService;
import com.kpms.knwrpl.vo.KnwRplVO;

@RestController
public class RestKnwRplController {
	@Autowired
	private KnwRplService knwRplService;
	
	@PostMapping("/api/knwrpl/create")
	public APIResponseVO doCreateKnwRpl(KnwRplVO knwRplVO, @SessionAttribute("__USER__") EmpVO empVO) {
		knwRplVO.setCrtr(empVO.getEmpId());
		knwRplVO.setMdfyr(empVO.getEmpId());
		boolean createResult = knwRplService.createNewKnwRpl(knwRplVO);
		if(createResult) {
			return new APIResponseVO(APIStatus.OK, "/knw/detail/" + knwRplVO.getKnwId());
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/knwrpl/update")
	public APIResponseVO doUpdateKnwRpl(KnwRplVO knwRplVO, @SessionAttribute("__USER__") EmpVO empVO) {
		knwRplVO.setMdfyr(empVO.getEmpId());
		boolean updateResult = knwRplService.updateOneKnwRpl(knwRplVO);
		if(updateResult) {
			return new APIResponseVO(APIStatus.OK, "/knw/detail/" + knwRplVO.getKnwId());
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/knwrpl/delete/{knwRplId}")
	public APIResponseVO doDeleteKnwRpl(@PathVariable String knwRplId) {
		boolean deleteResult = knwRplService.deleteOneKnwRpl(knwRplId);
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
}
