package com.kpms.dep.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@GetMapping("/dep/search")
	public String viewDepSearchPage(@RequestParam(required = false) String depNm,
									Model model) {
		model.addAttribute("depNm", depNm);
		if (depNm != null && depNm.length() > 0) {
			List<DepVO> depList = depService.readAllDepVONopagination(depNm);
			model.addAttribute("depList", depList);
		}
		
		return "dep/search";
	}
}
