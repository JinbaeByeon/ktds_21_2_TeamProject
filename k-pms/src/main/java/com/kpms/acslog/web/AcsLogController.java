package com.kpms.acslog.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.acslog.service.AcsLogService;
import com.kpms.acslog.vo.AcsLogVO;

@Controller
public class AcsLogController {

	@Autowired
	private AcsLogService acsLogService;
	
	@GetMapping("/emp/log/acs")
	public String viewAcsLogPage(Model model, AcsLogVO acsLogVO,String searchType) {
		List<AcsLogVO> acsLogList = acsLogService.readAllAcsLog(acsLogVO);
		model.addAttribute("acsLogList",acsLogList);
		if(!acsLogList.isEmpty()) {
			model.addAttribute("lastPage",acsLogList.get(0).getLastPage());
		}
		model.addAttribute("acsLogVO",acsLogVO);
		model.addAttribute("viewCnt",acsLogVO.getViewCnt());
		model.addAttribute("pageCnt",acsLogVO.getPageCnt());
		model.addAttribute("pageNo",acsLogVO.getPageNo());
		if(searchType==null) {
			searchType= "ID";
		}
		model.addAttribute("searchType",searchType);
		if(searchType.equals("ID")) {
			model.addAttribute("searchKeyword",acsLogVO.getCrtr());
		}
		else if(searchType.equals("이름")) {
			model.addAttribute("searchKeyword",acsLogVO.getEmp().getfNm());
		}
		return "emp/log/acs";
	}
}
