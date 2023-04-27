package com.kpms.req.web;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.api.vo.APIDataResponseVO;
import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIException;
import com.kpms.common.handler.UploadHandler;
import com.kpms.emp.vo.EmpVO;
import com.kpms.req.service.ReqService;
import com.kpms.req.vo.ReqVO;

@RestController
public class RestReqController {

	@Autowired
	private ReqService reqService;
	
	@PostMapping("/api/req/create")
	public APIResponseVO doCreateReq(ReqVO reqVO,
								@SessionAttribute("__USER__") EmpVO empVO) {
		reqVO.setCrtr(empVO.getEmpId());
		reqVO.setMdfyr(empVO.getEmpId());
		
		boolean createResult = reqService.createNewReq(reqVO);
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			throw new APIException(APIStatus.FAIL, "실패했어ㅜ");
		}
	}
	
	@PostMapping("/api/req/update")	
	public APIResponseVO doUpdateReq(ReqVO reqVO,
									  @SessionAttribute("__USER__") EmpVO empVO) {
		reqVO.setMdfyr(empVO.getEmpId());
		
		boolean updateResult = reqService.updateReq(reqVO);
		
		if(updateResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			throw new APIException(APIStatus.FAIL, "실패했어");
		}
	}
	
	@GetMapping("/api/req/delete/{reqId}")
	public APIResponseVO doDeleteReq(@PathVariable String reqId) {
		
		boolean deleteResult = reqService.deleteReqByReqId(reqId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/req/delete")
	public APIResponseVO doDeleteReqBySelectedReqId(@RequestParam List<String> reqId) {
		boolean deleteResult = reqService.deleteReqBySelectedReqId(reqId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
}
