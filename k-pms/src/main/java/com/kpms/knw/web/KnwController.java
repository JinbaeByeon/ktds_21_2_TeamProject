package com.kpms.knw.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.knw.service.KnwService;
import com.kpms.knw.vo.KnwVO;

@Controller
public class KnwController {

	@Autowired
	private KnwService knwService;
	
	@GetMapping("/knw/list")
	public String viewKnwListPage(KnwVO knwVO, Model model) {
		List<KnwVO> knwList = knwService.readAllKnw(knwVO);
		
		model.addAttribute("knwList", knwList);
		
		return "knw/list";
	}
}
