package com.kpms.tm.web;

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
import com.kpms.common.exception.APIArgsException;
import com.kpms.dep.vo.DepVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.tm.service.TmService;
import com.kpms.tm.vo.TmVO;

@RestController
public class RestTmController {

	@Autowired
	private TmService tmService;
	
	@PostMapping("/api/tm/create")
	public APIResponseVO doCreateTm(TmVO tmVO,
			 @SessionAttribute("__USER__") EmpVO empVO) {
		
		tmVO.setCrtr(empVO.getEmpId());
		tmVO.setMdfyr(empVO.getEmpId());
		
		boolean createResult = tmService.createOneTm(tmVO);
		
		if (createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "팀을 등록할 수 없습니다.", "500", "");
		}
	}
	
	@PostMapping("/api/tm/update/{tmId}")
	public APIResponseVO doUpadateTm(TmVO tmVO, DepVO depVO,
						 @SessionAttribute("__USER__") EmpVO empVO,
						 @PathVariable String tmId) {
		tmVO.setCrtr(empVO.getEmpId());
		tmVO.setMdfyr(empVO.getEmpId());
		tmVO.setTmHdId(tmVO.getTmHdId());
		tmVO.setDepId(depVO.getDepId());

		String tmNm = tmVO.getTmNm();
		
		if (tmNm == null || tmNm.trim().length() == 0) {
			throw new APIArgsException("400", "부서명이 누락되었습니다.");
		}
		
		boolean updateResult = tmService.updateOneTm(tmVO);
		
		if (updateResult) {
			return new APIResponseVO(APIStatus.OK, "/tm/detail/" + tmVO.getTmId());
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "팀을 수정할 수 없습니다.", "500", "");
		}
	}
	
	@GetMapping("/api/tm/delete/{tmId}")
	public APIResponseVO doDeleteTm(@PathVariable String tmId) {
		boolean deleteResult = tmService.deleteOneTmByTmId(tmId);
		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "팀을 삭제할 수 없습니다.", "500", "");
		}
	}
	
	@PostMapping("/api/tm/delete")
	public APIResponseVO doDeleteTmBySelectedTmId(@RequestParam List<String> tmId) {
		boolean deleteResult = tmService.deleteTmBySelectedTmId(tmId);
		
		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL,  "팀을 삭제할 수 없습니다.");
		}
	}
}
