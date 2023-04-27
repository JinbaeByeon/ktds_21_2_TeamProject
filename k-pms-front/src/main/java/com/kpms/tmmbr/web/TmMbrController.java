package com.kpms.tmmbr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpms.tmmbr.service.TmMbrService;
import com.kpms.tmmbr.vo.TmMbrVO;

@Controller
public class TmMbrController {
	
	@Autowired
	private TmMbrService tmMbrService;
	
	@GetMapping("/tmmbr/search")
	public String viewPrjSearchPage(@RequestParam(required=false) String tmNm, Model model) {
		model.addAttribute("tmNm", tmNm);
		List<TmMbrVO> tmMbrList = tmMbrService.readAllTmMbrVO(tmNm);
		model.addAttribute("tmMbrList", tmMbrList);
		return "tmmbr/search";
	}

}
