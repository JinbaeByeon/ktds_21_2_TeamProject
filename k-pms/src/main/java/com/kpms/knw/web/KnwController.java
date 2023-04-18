package com.kpms.knw.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

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
		model.addAttribute("knwVO", knwVO);
		
		if(!knwList.isEmpty()) {
			model.addAttribute("lastPage", knwList.get(0).getLastPage());
		}
		
		model.addAttribute("pageNo", knwVO.getPageNo());
		model.addAttribute("viewCnt", knwVO.getViewCnt());
		model.addAttribute("pageCnt", knwVO.getPageCnt());
		return "knw/list";
	}
	
	@GetMapping("/knw/create")
	public String viewKnwCreatePage() {
		return "knw/create";
	}
	
	@GetMapping("/knw/detail/{knwId}")
	public String viewKnwDetailPage(@PathVariable String knwId, Model model) {
		KnwVO knwVO = knwService.readOneKnwByKnwId(knwId);
		model.addAttribute("knwVO", knwVO);
		model.addAttribute("prjVO", knwVO.getPrjVO());
		
		return "knw/detail";
	}
}
