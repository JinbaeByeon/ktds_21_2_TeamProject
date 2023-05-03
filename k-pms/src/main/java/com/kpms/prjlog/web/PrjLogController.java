package com.kpms.prjlog.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.prjlog.vo.PrjLogVO;
import com.kpms.prjlog.service.PrjLogService;

@Controller
public class PrjLogController {
	
	@Autowired
	private PrjLogService prjLogService;
	
	@GetMapping("/prj/log")
	public String viewPrjLogListPage(Model model, PrjLogVO prjLogVO) {
		List<PrjLogVO> prjLogList = prjLogService.readAllPrjLog(prjLogVO);
			
			model.addAttribute("prjLogList", prjLogList);
			model.addAttribute("prjLogVO", prjLogVO);
			
			if(!prjLogList.isEmpty()) {
				model.addAttribute("lastPage",prjLogList.get(0).getLastPage());
		      }
		      model.addAttribute("pageNo", prjLogVO.getPageNo());
		      model.addAttribute("viewCnt", prjLogVO.getViewCnt());
		      model.addAttribute("pageCnt", prjLogVO.getPageCnt());
		      
			return "/prj/log";
	}
}
