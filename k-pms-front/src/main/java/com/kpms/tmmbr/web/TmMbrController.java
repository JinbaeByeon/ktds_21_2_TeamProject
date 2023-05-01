package com.kpms.tmmbr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.tm.service.TmService;
import com.kpms.tm.vo.TmVO;
import com.kpms.tmmbr.service.TmMbrService;
import com.kpms.tmmbr.vo.TmMbrVO;

@Controller
public class TmMbrController {
	
	@Autowired
	private TmMbrService tmMbrService;
	
	@GetMapping("/tmmbr/search")
	public String viewTmMbrSearchPage(TmVO tmVO, Model model) {
		List<TmMbrVO> tmMbrList = tmMbrService.readAllTmMbrVO(tmVO.getTmId());
		model.addAttribute("tmMbrList", tmMbrList);
		model.addAttribute("tmNm", tmVO.getTmNm());
		
		return "tmmbr/search";
	}
	
}
