package com.kpms.eqp.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpms.eqp.service.EqpService;
import com.kpms.eqp.vo.EqpVO;

@Controller
public class EqpController {
	
	@Autowired
	private EqpService eqpService;
	// 비품등록
	@GetMapping("/eqp/{searchMode}")
	public String viewEqpListPage(@PathVariable String searchMode, Model model, EqpVO eqpVO) {
		eqpVO.setSearchMode(searchMode);
		List<EqpVO> eqpList = eqpService.readAllEqp(eqpVO);
		
		model.addAttribute("eqpList", eqpList);
		model.addAttribute("eqpVO", eqpVO);
		
		if (!eqpList.isEmpty()) {
			model.addAttribute("lastPage", eqpList.get(0).getLastPage());
		}
		model.addAttribute("applStts", eqpVO.getApplStts());
		model.addAttribute("eqpNm", eqpVO.getEqpNm());
		model.addAttribute("pageNo", eqpVO.getPageNo());
		model.addAttribute("viewCnt", eqpVO.getViewCnt());
		model.addAttribute("pageCnt", eqpVO.getPageCnt());
		
		return "eqp/" + searchMode;
	}
	
	@GetMapping("/eqp/search")  
	public String viewEqpSearchPage(@RequestParam(required = false) String eqpNm,
												Model model) {
		
		model.addAttribute("eqpNm", eqpNm);
		
		List<EqpVO> eqpList = eqpService.readAllEqpNoPagination(eqpNm);
		model.addAttribute("eqpList", eqpList);

		return "eqp/search";
	}
	
	
	

	
}
