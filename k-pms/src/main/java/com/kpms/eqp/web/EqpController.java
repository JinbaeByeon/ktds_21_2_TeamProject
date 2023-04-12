package com.kpms.eqp.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.eqp.service.EqpService;
import com.kpms.eqp.vo.EqpVO;

@Controller
public class EqpController {
	
	@Autowired
	private EqpService eqpService;
	
	@GetMapping("/eqp")
	public String viewEqpListPage(Model model, EqpVO eqpVO) {
		List<EqpVO> eqpList = eqpService.readAllEqp(eqpVO);
		
		model.addAttribute("eqpList", eqpList);
		model.addAttribute("eqpVO", eqpVO);
		
		return "eqp/list";
	}
}
