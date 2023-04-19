package com.kpms.cmncd.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.cmncd.service.CmnCdService;
import com.kpms.cmncd.vo.CmnCdSearchVO;
import com.kpms.cmncd.vo.CmnCdVO;

@Controller
public class CmnCdController {

	@Autowired
	private CmnCdService cmnCdService;

	@GetMapping("/cmncd/list")
	public String viewCmnCdListPage(Model model, CmnCdSearchVO cmnCdSearchVO) {
		List<CmnCdVO> cmnCdList = cmnCdService.readAllCmnCd(cmnCdSearchVO);
		List<CmnCdVO> cmnCdTypeList = cmnCdService.readCmnCdType();
		
		model.addAttribute("cmnCdSearchVO", cmnCdSearchVO);
		model.addAttribute("cmnCdList", cmnCdList);
		model.addAttribute("cmnCdTypeList", cmnCdTypeList);

		if (!cmnCdList.isEmpty()) {
			model.addAttribute("lastPage", cmnCdList.get(0).getLastPage());
		}
		
		model.addAttribute("pageNo", cmnCdSearchVO.getPageNo());
		model.addAttribute("viewCnt", cmnCdSearchVO.getViewCnt());
		model.addAttribute("pageCnt", cmnCdSearchVO.getPageCnt());
		return "cmncd/list";
	}
}
