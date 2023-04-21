package com.kpms.eqplog.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.eqplog.service.EqpLogService;
import com.kpms.eqplog.vo.EqpLogVO;

@Controller
public class EqpLogController {

	@Autowired
	private EqpLogService eqpLogService;
	
	@GetMapping("/eqplog/list")
	public String viewEqpLogListPage(Model model, EqpLogVO eqpLogVO) {
		List<EqpLogVO> eqpLogList = eqpLogService.readAllEqpLog(eqpLogVO);
		
		model.addAttribute("eqpLogList", eqpLogList);
		model.addAttribute("eqpLogVO", eqpLogVO);
		
		if(!eqpLogList.isEmpty()) {
	         model.addAttribute("lastPage",eqpLogList.get(0).getLastPage());
	      }
	      model.addAttribute("pageNo", eqpLogVO.getPageNo());
	      model.addAttribute("viewCnt", eqpLogVO.getViewCnt());
	      model.addAttribute("pageCnt", eqpLogVO.getPageCnt());
		
		return "eqplog/list";
	}
	
}
