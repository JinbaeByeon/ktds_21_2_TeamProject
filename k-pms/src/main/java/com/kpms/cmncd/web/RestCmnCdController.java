package com.kpms.cmncd.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.cmncd.service.CmnCdService;
import com.kpms.cmncd.vo.CmnCdVO;
import com.kpms.common.api.vo.APIDataResponseVO;
import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.vo.EmpVO;

@RestController
public class RestCmnCdController {
	
	@Autowired
	private CmnCdService cmnCdService;
	
	@PostMapping("/api/cmncd/create")
	public APIResponseVO doCreateCmnCd(CmnCdVO cmnCdVO, @SessionAttribute("__USER__") EmpVO empVO) {	
		cmnCdVO.setCrtr(empVO.getCrtr());
		cmnCdVO.setMdfyr(empVO.getMdfyr());
		
		boolean createResult = cmnCdService.createOneCmnCd(cmnCdVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/cmncd/update")
	public APIResponseVO doUpdateCmnCd(CmnCdVO cmnCdVO, @SessionAttribute("__USER__") EmpVO empVO) {
		cmnCdVO.setMdfyr(empVO.getEmpId());
		
		boolean createResult = cmnCdService.updateOneCmnCd(cmnCdVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@GetMapping("/api/cmncd/delete/{cmnCdId}")
	public APIResponseVO doDeleteCmnCd(@PathVariable String cdId) {
		boolean deleteResult = cmnCdService.deleteOneCmnCdByCdId(cdId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/cmncd/delete")
	public APIResponseVO doDeleteCmnCdBySelectedCmnCdId(@RequestParam List<String> cdId) {
		boolean deleteResult = cmnCdService.deleteCmnCdBySelectedCmnCdId(cdId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@GetMapping("/api/cmncd/list/{prcdncCdId}")
	public APIDataResponseVO getCmncdList(@PathVariable String prcdncCdId) {
		List<CmnCdVO> cdResult = cmnCdService.readCmnCdNameByPrcdncCdId(prcdncCdId);
		return new APIDataResponseVO(APIStatus.OK, cdResult);
	}

}
