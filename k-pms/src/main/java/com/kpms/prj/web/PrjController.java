package com.kpms.prj.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.prj.service.PrjService;
import com.kpms.prj.vo.PrjVO;

@Controller
public class PrjController {
	
	@Autowired
	private PrjService prjService;
	
	@GetMapping("/prj")
	public String viewPrjListPage(Model model, PrjVO prjVO) {
		List<PrjVO> prjList = prjService.readAllPrjVO(prjVO);
		model.addAttribute("prjList", prjList);
		model.addAttribute("prjVO", prjVO);
		return "prj/list";
	}
}
