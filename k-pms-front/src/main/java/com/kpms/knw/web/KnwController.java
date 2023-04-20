package com.kpms.knw.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.emp.vo.EmpVO;
import com.kpms.knw.service.KnwService;
import com.kpms.knw.vo.KnwSearchVO;
import com.kpms.knw.vo.KnwVO;

@Controller
public class KnwController {

	@Autowired
	private KnwService knwService;
	
	@GetMapping("/knw/list")
	public String viewKnwListPage(KnwSearchVO knwSearchVO, Model model) {
		List<KnwVO> knwList = knwService.readAllKnw(knwSearchVO);
		model.addAttribute("knwList", knwList);
		model.addAttribute("knwSearchVO", knwSearchVO);
		
		if(!knwList.isEmpty()) {
			model.addAttribute("lastPage", knwList.get(0).getLastPage());
		}
		
		model.addAttribute("pageNo", knwSearchVO.getPageNo());
		model.addAttribute("viewCnt", knwSearchVO.getViewCnt());
		model.addAttribute("pageCnt", knwSearchVO.getPageCnt());
		return "knw/list";
	}
	
	@GetMapping("/knw/create")
	public String viewKnwCreatePage() {
		return "knw/create";
	}
	
	@GetMapping("/knw/detail/{knwId}")
	public String viewKnwDetailPage(@PathVariable String knwId, Model model, @SessionAttribute("__USER__") EmpVO empVO) {
		KnwVO knwVO = knwService.readOneKnwByKnwId(knwId);
		
		model.addAttribute("knwVO", knwVO);
		model.addAttribute("prjVO", knwVO.getPrjVO());
		
		return "knw/detail";
	}
}
