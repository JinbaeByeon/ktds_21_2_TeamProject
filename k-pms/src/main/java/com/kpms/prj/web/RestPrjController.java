package com.kpms.prj.web;

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
import com.kpms.prj.service.PrjService;
import com.kpms.prj.vo.PrjVO;

@RestController
public class RestPrjController {
	
	@Autowired
	private PrjService prjService;
	
	@PostMapping("/api/prj/create")
	public APIResponseVO doCreatePrj(PrjVO prjVO, @SessionAttribute("__USER__") EmpVO empVO) {
		
		prjVO.setCrtr(empVO.getCrtr());
		prjVO.setMdfyr(empVO.getMdfyr());
		
		boolean createResult = prjService.createOnePrj(prjVO);
		if (createResult) {
			return new APIResponseVO(APIStatus.OK, "/prj/detail/" + prjVO.getPrjId());
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "프로젝트 등록 실패", "");
		}
	}
	
	@PostMapping("/api/prj/update")
	public APIResponseVO doUpdatePrj(PrjVO prjVO, @SessionAttribute("__USER__") EmpVO empVO) {
		prjVO.setMdfyr(empVO.getMdfyr());
		
		boolean isSuccess = prjService.updateOnePrj(prjVO);
		if (isSuccess) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@GetMapping("/api/prj/delete/{prjId}")
	public APIResponseVO deDeletePrj(@PathVariable String prjId) {
		boolean deleteResult = prjService.deleteOnePrjByPrjId(prjId);
		
		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "프로젝트 삭제 실패");
		}
	}
	
	@PostMapping("/api/prj/delete")
	public APIResponseVO doDeletePrjBySelectedPrjId(@RequestParam List<String> prjId) {
		boolean deleteResult = prjService.deletePrjByPrjList(prjId);
		
		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "프로젝트 삭제 실패");
		}
	}
}
