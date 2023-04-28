package com.kpms.req.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.emp.vo.EmpVO;
import com.kpms.issu.service.IssuService;
import com.kpms.issu.vo.IssuVO;
import com.kpms.req.service.ReqService;
import com.kpms.req.vo.ReqVO;
import com.kpms.tmmbr.vo.TmMbrVO;

@Controller
public class ReqController {

	@Autowired
	private ReqService reqService;
	@Autowired
	private IssuService issuService;

	@GetMapping("/req/{searchMode}")
	public String viewReqListPage(@PathVariable String searchMode, Model model, ReqVO reqVO, TmMbrVO tmMbrVO , @SessionAttribute("__USER__") EmpVO empVO) {
		reqVO.setSearchMode(searchMode);
		
		String empId = empVO.getEmpId();
		tmMbrVO.setEmpId(empId);
		reqVO.setTmMbrVO(tmMbrVO);
		
		List<ReqVO> reqList = reqService.readAllReq(reqVO);
		
		model.addAttribute("reqList", reqList);
		model.addAttribute("reqVO", reqVO);
		
		if (!reqList.isEmpty()) {
			model.addAttribute("lastPage", reqList.get(0).getLastPage());
		}
		model.addAttribute("reqId", reqVO.getReqId());
		model.addAttribute("pageNo", reqVO.getPageNo());
		model.addAttribute("viewCnt", reqVO.getViewCnt());
		model.addAttribute("pageCnt", reqVO.getPageCnt());

		return "req/" + searchMode;
	}

	 @GetMapping("/req/detail/{reqId}") 
	 public String viewReqDetailPage(@PathVariable String reqId, Model model, @SessionAttribute("__USER__") EmpVO empVO) {
	  
		 ReqVO reqVO = reqService.readReqByReqId(reqId);
		 model.addAttribute("reqVO", reqVO);
		 model.addAttribute("reqId", reqId);
		 
		 IssuVO issuVO = new IssuVO();
		 issuVO.setReqId(reqId);
		 List<IssuVO> issuList = issuService.readIssuList(issuVO);
		 model.addAttribute("issuList", issuList);
		 
		 if (!issuList.isEmpty()) {
				model.addAttribute("lastPage", issuList.get(0).getLastPage());
			}
			model.addAttribute("reqId", issuVO.getReqId());
			model.addAttribute("pageNo", issuVO.getPageNo());
			model.addAttribute("viewCnt", issuVO.getViewCnt());
			model.addAttribute("pageCnt", issuVO.getPageCnt());
		 
		 return "req/detail"; 
	 }
	 
	 @GetMapping("/req/update/{reqId}") 
	 public String viewReqUpdatePage(@PathVariable String reqId, Model model, @SessionAttribute("__USER__") EmpVO empVO) {
		 
		 ReqVO reqVO = reqService.readReqByReqId(reqId);
		 model.addAttribute("reqVO", reqVO);
		 model.addAttribute("reqId", reqId);
		 
		 return "req/update"; 
	 }
	 
}
