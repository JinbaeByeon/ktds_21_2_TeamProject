package com.kpms.tmmbr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIDataResponseVO;
import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.tmmbr.service.TmMbrService;
import com.kpms.tmmbr.vo.TmMbrVO;

@RestController
public class RestTmMbrContoller {
	
	@Autowired
	private TmMbrService tmMbrSevice;
	
	@GetMapping("/api/tmmbr/list/{tmid}")
	public APIResponseVO readTmMbrList(@PathVariable String tmid) {
		List<TmMbrVO> tmmbrList = tmMbrSevice.readAllTmMbrVO(tmid);
		return new APIDataResponseVO(APIStatus.OK, tmmbrList);
	}
}
