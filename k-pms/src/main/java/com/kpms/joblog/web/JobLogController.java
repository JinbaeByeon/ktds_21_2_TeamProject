package com.kpms.joblog.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpms.joblog.service.JobLogService;
import com.kpms.joblog.vo.JobLogVO;

@Controller
public class JobLogController {
	
	@Autowired
	private JobLogService jobLogService;
	
	@GetMapping("/emp/log/job")
	public String viewJobLogListPage(Model model, JobLogVO jobLogVO,String searchType) {
		List<JobLogVO> jobLogList = jobLogService.readAllJobLogVO(jobLogVO);
			
		model.addAttribute("jobLogList", jobLogList);
		model.addAttribute("jobLogVO", jobLogVO);
		
		if(!jobLogList.isEmpty()) {
			model.addAttribute("lastPage",jobLogList.get(0).getLastPage());
		}
		model.addAttribute("pageNo", jobLogVO.getPageNo());
		model.addAttribute("viewCnt", jobLogVO.getViewCnt());
		model.addAttribute("pageCnt", jobLogVO.getPageCnt());
		if(searchType==null) {
			searchType= "ID";
		}
		model.addAttribute("searchType",searchType);
		if(searchType.equals("ID")) {
			model.addAttribute("searchKeyword",jobLogVO.getEmpId());
		}
		else if(searchType.equals("이름")) {
			model.addAttribute("searchKeyword",jobLogVO.getEmpVO().getfNm());
		}
		
		return "/emp/log/job";
	}
}
