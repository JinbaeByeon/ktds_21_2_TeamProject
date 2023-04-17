package com.kpms.prj.web;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.kpms.prj.service.PrjService;
import com.kpms.prj.vo.PrjVO;
import com.kpms.prjtmmbr.vo.PrjTmMbrVO;
import com.kpms.tm.vo.TmVO;
import com.kpms.tmmbr.vo.TmMbrVO;

@Controller
public class PrjController {
	
	@Autowired
	private PrjService prjService;
	
	@GetMapping("/prj/create")
	public String viewPrjCreatePage() {
		return "prj/create";
	}
	
	@GetMapping("/prj/update/{prjId}")
	public String viewPrjUpdatePage(@PathVariable String prjId, Model model) {
		PrjVO prjVO = prjService.readOnePrjVOByPrjId(prjId);
		model.addAttribute("prjVO", prjVO);
		return "prj/update";
	}
	
	@GetMapping("/prj/list")
	public String viewPrjListPage(Model model, PrjVO prjVO) {
		List<PrjVO> prjList = prjService.readAllPrjVO(prjVO);
		if(!prjList.isEmpty()) {
	         model.addAttribute("lastPage",prjList.get(0).getLastPage());
	    }
	    
		model.addAttribute("prjList", prjList);
		model.addAttribute("prjVO", prjVO);
	    model.addAttribute("prjNm", prjVO.getPrjNm());
	    model.addAttribute("pageNo", prjVO.getPageNo());
	    model.addAttribute("viewCnt", prjVO.getViewCnt());
	    model.addAttribute("pageCnt", prjVO.getPageCnt());
		return "prj/list";
	}
	
	@GetMapping("/prj/detail/{prjId}")
	public String viewPrjDetailPage(Model model, @PathVariable String prjId) {
		PrjVO prjVO = prjService.readOnePrjVOByPrjId(prjId);
		model.addAttribute("prjVO", prjVO);
		Map<String, String> tmMap = new HashMap<String, String>();
		for(PrjTmMbrVO prjTmMbr : prjVO.getPrjTmMbrVO()) {
			TmVO tmVO =  prjTmMbr.getTmMbrVO().getTmVO();
			tmMap.put(tmVO.getTmId(), tmVO.getTmNm());
		}
	    model.addAttribute("tmList",tmMap.entrySet());
		return "prj/detail";
	}
	
	@GetMapping("/prj/search")
	public String viewPrjDetailPage(@RequestParam(required=false) String prjNm, Model model) {
		model.addAttribute("prjNm", prjNm);
		List<PrjVO> prjList = prjService.readAllPrjVONoPagination(prjNm);
		model.addAttribute("prjList", prjList);
		return "prj/search";
	}
	
}
