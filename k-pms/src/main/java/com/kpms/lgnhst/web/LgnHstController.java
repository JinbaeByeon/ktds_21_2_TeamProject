package com.kpms.lgnhst.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.lgnhst.service.LgnHstService;
import com.kpms.lgnhst.vo.LgnHstVO;

@Controller
public class LgnHstController {

	@Autowired
	private LgnHstService lgnHstService;
	
	@GetMapping("/emp/log/lgn")
	public String readLgnHst(Model model,LgnHstVO lgnHstVO)
	{
		List<LgnHstVO> lgnHstList = lgnHstService.readAllLgnHst(lgnHstVO);
		model.addAttribute("lgnHstList",lgnHstList);
		if(!lgnHstList.isEmpty()) {
			model.addAttribute("lastPage",lgnHstList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",lgnHstVO.getPageNo());
		model.addAttribute("pageCnt",lgnHstVO.getPageCnt());
		model.addAttribute("viewCnt",lgnHstVO.getViewCnt());
		return "emp/log/lgn";
	}
}
