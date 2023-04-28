package com.kpms.pstn.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpms.pstn.service.PstnService;
import com.kpms.pstn.vo.PstnVO;

@Controller
public class PstnController {

	@Autowired
	private PstnService pstnService;
	
	@GetMapping("/pstn/list")  
	public String viewPstnListPage(Model model, PstnVO pstnVO) {
		List<PstnVO> pstnList = pstnService.readAllPstn(pstnVO);
		
		model.addAttribute("pstnList", pstnList);
		model.addAttribute("pstnVO", pstnVO);
		if(!pstnList.isEmpty()) {
			model.addAttribute("lastPage",pstnList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",pstnVO.getPageNo());
		model.addAttribute("pageCnt",pstnVO.getPageCnt());
		model.addAttribute("viewCnt",pstnVO.getViewCnt());
		return "pstn/list";
	}
	
	
	@GetMapping("/pstn/search")  
	public String viewPstnSearchPage(@RequestParam(required = false) String pstnNm,
												Model model) {
		
		model.addAttribute("pstnNm", pstnNm);
		
		if (pstnNm != null && pstnNm.length() > 0) {
			List<PstnVO> pstnList = pstnService.readAllPstnNoPagination(pstnNm);
			model.addAttribute("pstnList", pstnList);
		}

		return "pstn/search";
	}
}
