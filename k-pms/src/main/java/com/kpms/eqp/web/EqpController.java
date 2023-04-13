package com.kpms.eqp.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpms.eqp.service.EqpService;
import com.kpms.eqp.vo.EqpVO;
import com.kpms.pstn.vo.PstnVO;

@Controller
public class EqpController {
	
	@Autowired
	private EqpService eqpService;
	
	@GetMapping("/eqp")
	public String viewEqpListPage(Model model, EqpVO eqpVO) {
		List<EqpVO> eqpList = eqpService.readAllEqp(eqpVO);
		
		model.addAttribute("eqpList", eqpList);
		model.addAttribute("eqpVO", eqpVO);
		
		if(!eqpList.isEmpty()) {
	         model.addAttribute("lastPage",eqpList.get(0).getLastPage());
	      }
	      model.addAttribute("gnrNm", eqpVO.getEqpNm());
	      model.addAttribute("pageNo", eqpVO.getPageNo());
	      model.addAttribute("viewCnt", eqpVO.getViewCnt());
	      model.addAttribute("pageCnt", eqpVO.getPageCnt());
		
		return "eqp/list";
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
