package com.kpms.dep.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpms.dep.service.DepService;
import com.kpms.dep.vo.DepVO;
import com.kpms.dep.vo.DeptSearchVO;

@Controller
public class DepController {

	@Autowired
	private DepService depService;
	
	@GetMapping("/dep/list")
	public String viewDepListPage(DeptSearchVO deptSearchVO, Model model) {
		
		List<DepVO> depList = depService.readAllDepVO(deptSearchVO);
		
		model.addAttribute("depList", depList);
		model.addAttribute("depVO", deptSearchVO);
		
		if (!depList.isEmpty()) {
			model.addAttribute("lastPage", depList.get(0).getLastPage());
		}
		model.addAttribute("pageNo", deptSearchVO.getPageNo());
		model.addAttribute("viewCnt", deptSearchVO.getViewCnt());
		model.addAttribute("pageCnt", deptSearchVO.getPageCnt());
		
		return "dep/list";
	}
	
	@GetMapping("/dep/detail/{depId}")
	public String viewDetailPage(@PathVariable String depId, Model model) {
		DepVO depVO = depService.readOneDepVOByDepId(depId);
		model.addAttribute("depVO", depVO);
		
		return "dep/detail";
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
