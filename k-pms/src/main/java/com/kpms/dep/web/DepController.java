package com.kpms.dep.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.dep.service.DepService;
import com.kpms.dep.vo.DepVO;

@Controller
public class DepController {

	@Autowired
	private DepService depService;
	
	@GetMapping("/dep/list")
	public String viewDepListPage(DepVO depVO, Model model) {
		List<DepVO> depList = depService.readAllDepVO(depVO);
		model.addAttribute("depList", depList);
		model.addAttribute("depVO", depVO);
		
		return "dep/list";
	}
}
