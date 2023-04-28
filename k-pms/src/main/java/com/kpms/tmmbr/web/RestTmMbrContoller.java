package com.kpms.tmmbr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIDataResponseVO;
import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.vo.EmpVO;
import com.kpms.tmmbr.service.TmMbrService;
import com.kpms.tmmbr.vo.TmMbrVO;

@RestController
public class RestTmMbrContoller {
	
	@Autowired
	private TmMbrService tmMbrSevice;
	
	@GetMapping("/api/tmmbr/list/{tmid}")
	public APIResponseVO readTmMbrList(@PathVariable String tmid) {
		List<TmMbrVO> tmmbrList = tmMbrSevice.readAllTmMbrVO(tmid);
		return new APIDataResponseVO(APIStatus.OK, tmmbrList);
	}
	
	@GetMapping("/api/tmmbr/lists/{tmid}")
	public APIResponseVO readTmMbrListInTm(@PathVariable String tmid) {
		List<TmMbrVO> tmmbrList = tmMbrSevice.readAllTmMbrInTm(tmid);
		return new APIDataResponseVO(APIStatus.OK, tmmbrList);
	}
	
	@PostMapping("/api/tmmbr/create")
	public APIResponseVO doCreateTmMbr(TmMbrVO tmMbrVO,
				@SessionAttribute("__USER__") EmpVO empVO) {
		
		tmMbrVO.setCrtr(empVO.getEmpId());
		tmMbrVO.setMdfyr(empVO.getEmpId());
		
		boolean createResult = tmMbrSevice.createOneTmMbr(tmMbrVO);
		
		if (createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "팀원을 등록할 수 없습니다.", "500", "");
		}
	}
	
	@GetMapping("/api/tmmbr/delete/{tmMbrId}")
	public APIResponseVO doDeleteTmMbr(@PathVariable String tmMbrId) {
		boolean deleteResult = tmMbrSevice.deleteOneTmMbrByTmMbrId(tmMbrId);
		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL, "팀원을 삭제할 수 없습니다.", "500", "");
		}
	}
	
	@PostMapping("/api/tmmbr/delete")
	public APIResponseVO doDeleteTmMbrBySelectedTmMbrId(@RequestParam List<String> tmMbrId) {
		boolean deleteResult = tmMbrSevice.deleteTmMbrBySelectedTmMbrId(tmMbrId);
		
		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL,  "팀원을 삭제할 수 없습니다.");
		}
	}
}
