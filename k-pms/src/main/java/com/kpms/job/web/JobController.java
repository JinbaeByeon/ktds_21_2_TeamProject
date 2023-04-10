package com.kpms.job.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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
		
		return "job/list";
		
		}
	}
