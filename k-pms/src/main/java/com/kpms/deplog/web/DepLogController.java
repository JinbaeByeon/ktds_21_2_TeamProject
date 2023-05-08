package com.kpms.deplog.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.deplog.service.DepLogService;
import com.kpms.deplog.vo.DepLogVO;

@Controller
public class DepLogController {
	
	@Autowired
	private DepLogService depLogService;
	
	@GetMapping("/emp/log/dep")
	public String viewDepLogListPage(Model model, DepLogVO depLogVO, String searchType) {
		List<DepLogVO> depLogList = depLogService.readAllDepLogVO(depLogVO);
			
		model.addAttribute("depLogList", depLogList);
		model.addAttribute("depLogVO", depLogVO);
		
		if(!depLogList.isEmpty()) {
			model.addAttribute("lastPage",depLogList.get(0).getLastPage());
	    }
	    model.addAttribute("pageNo", depLogVO.getPageNo());
	    model.addAttribute("viewCnt", depLogVO.getViewCnt());
	    model.addAttribute("pageCnt", depLogVO.getPageCnt());
		if(searchType==null) {
			searchType= "ID";
		}
		model.addAttribute("searchType",searchType);
		if(searchType.equals("ID")) {
			model.addAttribute("searchKeyword",depLogVO.getEmpId());
		}
		else if(searchType.equals("이름")) {
			model.addAttribute("searchKeyword",depLogVO.getEmpVO().getfNm());
		}
		return "/emp/log/dep";
	}
}
