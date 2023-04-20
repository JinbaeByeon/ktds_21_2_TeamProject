package com.kpms.tm.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpms.tm.service.TmService;
import com.kpms.tm.vo.TmSearchVO;
import com.kpms.tm.vo.TmVO;

@Controller
public class TmController {

	@Autowired
	private TmService tmService;
	
	
	@GetMapping("/tm/list")
	public String viewTmListPage(TmSearchVO tmSearchVO, Model model) {
		
		List<TmVO> tmList = tmService.readAllTmVO(tmSearchVO);
		
		model.addAttribute("tmList", tmList);
		model.addAttribute("tmVO", tmSearchVO);
		
		if(!tmList.isEmpty()) {
			model.addAttribute("lastPage",tmList.get(0).getLastPage());
	      }
	      model.addAttribute("tmNm", tmSearchVO.getTmNm());
	      model.addAttribute("pageNo", tmSearchVO.getPageNo());
	      model.addAttribute("viewCnt", tmSearchVO.getViewCnt());
	      model.addAttribute("pageCnt", tmSearchVO.getPageCnt());
		
		return "tm/list";
	}
	
	
	@GetMapping("tm/create")
	public String viewTmCreatePage() {
		return "tm/create";
	}
	
	@GetMapping("/tm/detail/{tmId}")
	public String viewDetailPage(@PathVariable String tmId, Model model) {
		TmVO tmVO = tmService.readOneTmVOByTmId(tmId);
		model.addAttribute("tmVO", tmVO);
		
		return "tm/detail";
	}
	
	@GetMapping("/tm/update/{tmId}")
	public String viewUpdatePage(@PathVariable String tmId, Model model) {
		TmVO tmVO = tmService.readOneTmVOByTmId(tmId);
		model.addAttribute("tmVO", tmVO);
		return "tm/update";
	}
	
	@GetMapping("/tm/search")
	public String viewTmSearchPage(@RequestParam(required = false) String tmNm,
									Model model) {
		model.addAttribute("tmNm", tmNm);
		if (tmNm != null && tmNm.length() > 0) {
			List<TmVO> tmList = tmService.readAllTmVONopagination(tmNm);
			model.addAttribute("tmList", tmList);
		}
		
		return "tm/search";
	}
	
	@GetMapping("/tm/allsearch")
	public String viewTmandTmMbrSearchPage(String tmNm, Model model) {
		model.addAttribute("tmNm", tmNm);
		if (tmNm != null && tmNm.length() > 0) {
			List<TmVO> tmList = tmService.readAllTmVONopagination(tmNm);
			model.addAttribute("tmList", tmList);
		}
		
		return "tm/allsearch";
	}
}
