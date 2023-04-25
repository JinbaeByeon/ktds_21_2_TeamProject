package com.kpms.prjtmmbr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.prjtmmbr.service.PrjTmMbrService;
import com.kpms.prjtmmbr.vo.PrjTmMbrSearchVO;
import com.kpms.prjtmmbr.vo.PrjTmMbrVO;

@Controller
public class PrjTmMbrController {
	
	@Autowired
	private PrjTmMbrService prjTmMbrService;
	
	@GetMapping("/prjtmmbr/search")
	public String viewPrjTmMbrPage(PrjTmMbrSearchVO prjTmMbrSearchVO, Model model) {
		List<PrjTmMbrVO> ptmList = prjTmMbrService.readAllPrjTmMbrVO(prjTmMbrSearchVO);
		model.addAttribute("ptmList", ptmList);
		
		return "prjtmmbr/search";
	}
}
