package com.kpms.job.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpms.job.service.JobService;
import com.kpms.job.vo.JobVO;

@Controller
public class JobController {

	@Autowired
	private JobService jobService;
	
	@GetMapping("/job/list")
	public String viewJobListPage(Model model, JobVO jobVO) {
		List<JobVO>jobList = jobService.readAllJobVO(jobVO);
		
		model.addAttribute("jobList", jobList);
		model.addAttribute("jobVO", jobVO);
		
		if(!jobList.isEmpty()) {
	         model.addAttribute("lastPage",jobList.get(0).getLastPage());
	      }
	      model.addAttribute("jobNm", jobVO.getJobNm());
	      model.addAttribute("pageNo", jobVO.getPageNo());
	      model.addAttribute("viewCnt", jobVO.getViewCnt());
	      model.addAttribute("pageCnt", jobVO.getPageCnt());
		
		return "job/list";
	}
	
	@GetMapping("/job/search")
	public String viewJobSearchPage(@RequestParam(required=false) String jobNm, Model model) {
		model.addAttribute("jobNm", jobNm);
		if(jobNm != null && jobNm.length() > 0) {
			List<JobVO> jobList = jobService.readAllJobVONoPagination(jobNm);
			model.addAttribute("jobList", jobList);
		}
		return "job/search";
	}
	
}
