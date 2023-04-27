package com.kpms.issu.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.issu.service.IssuService;
import com.kpms.issu.vo.IssuVO;

@RestController
public class RestIssuController {

	@Autowired
	private IssuService issuService;
	
	@PostMapping("/api/issu/create")
	public APIResponseVO doCreateIssu(IssuVO issuVO) {
		if(issuService.createOneIssu(issuVO)) {
			return new APIResponseVO(APIStatus.OK,"/issu/list");
		}
		return new APIResponseVO(APIStatus.FAIL);
	}
	
	@PostMapping("/api/issu/delete")
	public APIResponseVO doDeleteIssu(@RequestParam List<String> issuId) {
		
		if(issuService.deleteIssu(issuId)) {
			return new APIResponseVO(APIStatus.OK,"/issu/list");
		}
		return new APIResponseVO(APIStatus.FAIL);
	}

	@PostMapping("/api/issu/update")
	public APIResponseVO doUpdateIssu(IssuVO issuVO) {
		if(issuService.updateOneIssu(issuVO)) {
			return new APIResponseVO(APIStatus.OK,"/issu/list");
		}
		return new APIResponseVO(APIStatus.FAIL);
	}
}
