package com.kpms.pstn.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.pstn.service.PstnService;
import com.kpms.pstn.vo.PstnVO;

@Controller
public class PstnController {

	@Autowired
	private PstnService pstnService;
	
	@GetMapping("/pstn")  
	public String viewPstnListPage(Model model, PstnVO pstnVO) {
		List<PstnVO> pstnList = pstnService.readAllPstn(pstnVO);
		
		model.addAttribute("pstnList", pstnList);
		model.addAttribute("pstnVO", pstnVO);

		return "pstn/list";
	}
	
}
