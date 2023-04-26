package com.kpms.req.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.emp.vo.EmpVO;
import com.kpms.req.service.ReqService;
import com.kpms.req.vo.ReqVO;

@Controller
public class ReqController {

	@Autowired
	private ReqService reqService;

	@GetMapping("/req/{searchMode}")
	public String viewReqListPage(@PathVariable String searchMode, Model model, ReqVO reqVO, @SessionAttribute("__USER__") EmpVO empVO) {
		reqVO.setSearchMode(searchMode);
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
		 
		 return "req/detail"; 
	 }
	 
}
