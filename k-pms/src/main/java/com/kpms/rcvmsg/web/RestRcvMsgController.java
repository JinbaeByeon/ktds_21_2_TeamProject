package com.kpms.rcvmsg.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.rcvmsg.service.RcvMsgService;

@RestController
public class RestRcvMsgController {

	@Autowired 
	private RcvMsgService rcvMsgService;
	
	@GetMapping("/api/rcvmsg/delete/{empId}")
	public APIResponseVO doDeleteRcvMsg(@PathVariable String empId) {
		boolean deleteResult = rcvMsgService.deleteOneRcvMsg(empId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
}
