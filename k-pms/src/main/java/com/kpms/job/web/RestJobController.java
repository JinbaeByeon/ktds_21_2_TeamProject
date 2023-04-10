package com.kpms.job.web;

import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.job.service.JobService;
import com.kpms.job.vo.JobVO;

@RestController
public class RestJobController {
	
	private JobService jobService;
	
	private APIResponseVO doCreateJob(JobVO jobVO) {
		boolean createResult = jobService.createOneJob(jobVO);
		
		if(createResult) {
			return new APIResponseVO(APIStatus.OK);
		}
		else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

}
