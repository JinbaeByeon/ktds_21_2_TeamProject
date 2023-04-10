package com.kpms.cmncd.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.cmncd.service.CmnCdService;
import com.kpms.cmncd.vo.CmnCdVO;

@Controller
public class CmnCdController {

	@Autowired
	private CmnCdService cmnCdService;
	
	@GetMapping("/cmncd/list")
	public String viewCmnCdListPage(Model model, CmnCdVO cmnCdVO) {
		List<CmnCdVO> cmnCdList = cmnCdService.readAllCmnCd(cmnCdVO);
		
		model.addAttribute("cmnCdList", cmnCdList);
		model.addAttribute("cmnCdVO", cmnCdVO);
		
		return "cmncd/list";
	}
}
