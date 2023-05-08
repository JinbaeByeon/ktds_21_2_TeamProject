package com.kpms.pstnlog.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.pstnlog.service.PstnLogService;
import com.kpms.pstnlog.vo.PstnLogVO;

@Controller
public class PstnLogController {
	
	@Autowired
	private PstnLogService pstnLogService;
	
	@GetMapping("/emp/log/pstn")
	public String viewPstnLogListPage(Model model, PstnLogVO pstnLogVO, String searchType) {
		List<PstnLogVO> pstnLogList = pstnLogService.readAllPstnLogVO(pstnLogVO);
		
		model.addAttribute("pstnLogList", pstnLogList);
		model.addAttribute("pstnLogVO", pstnLogVO);
		
		if(!pstnLogList.isEmpty()) {
			model.addAttribute("lastPage",pstnLogList.get(0).getLastPage());
	    }
	    model.addAttribute("pageNo", pstnLogVO.getPageNo());
	    model.addAttribute("viewCnt", pstnLogVO.getViewCnt());
	    model.addAttribute("pageCnt", pstnLogVO.getPageCnt());
		if(searchType==null) {
			searchType= "ID";
		}
		model.addAttribute("searchType",searchType);
		if(searchType.equals("ID")) {
			model.addAttribute("searchKeyword",pstnLogVO.getEmpId());
		}
		else if(searchType.equals("이름")) {
			model.addAttribute("searchKeyword",pstnLogVO.getEmpVO().getfNm());
		}
		return "/emp/log/pstn";
	}

}
