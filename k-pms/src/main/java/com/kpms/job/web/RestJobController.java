package com.kpms.job.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.vo.EmpVO;
import com.kpms.job.service.JobService;
import com.kpms.job.vo.JobVO;

@RestController
public class RestJobController {
	
	@Autowired
	private JobService jobService;
	
	@PostMapping("/api/job/create")
	public APIResponseVO doCreateJob(JobVO jobVO) {
		jobVO.setCrtr("임시 값");
		jobVO.setMdfyr("임시 값");
		boolean createResult = jobService.createOneJob(jobVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/job/update")
	public APIResponseVO doUpdateJob(JobVO jobVO, @SessionAttribute("__USER__") EmpVO empVO) {
		
		jobVO.setMdfyr(empVO.getEmpId());
		
		boolean updateResult = jobService.updateOneJob(jobVO);
		
		if(updateResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@GetMapping("/api/job/delete/{jobId}")
	public APIResponseVO doDeleteJob(@PathVariable int jobId) {
		boolean deleteResult = jobService.deleteOneJobByJobId(jobId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	@PostMapping("/api/job/delete")
	public APIResponseVO doDeleteJobBySelectedJobId(@RequestParam List<Integer> jobId) {
		boolean deleteResult = jobService.deleteJobBySelectedJobId(jobId);
		
		if(deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
}
