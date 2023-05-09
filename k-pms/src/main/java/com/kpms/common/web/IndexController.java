package com.kpms.common.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.dep.service.DepService;
import com.kpms.dep.vo.DepVO;
import com.kpms.dep.vo.DeptSearchVO;
import com.kpms.emp.service.EmpService;
import com.kpms.emp.vo.EmpVO;

@Controller
public class IndexController {
	
	@Autowired
	private DepService depService;
	@Autowired
	private EmpService empService;
	
	@GetMapping("/index")
	public String viewIndexPage(DeptSearchVO deptSearchVO, Model model, EmpVO empVO, String searchType) {
		
		List<EmpVO> empList = empService.readEmpList(empVO);
		model.addAttribute("empList",empList);
		if(!empList.isEmpty()) {
			model.addAttribute("lastPage",empList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",empVO.getPageNo());
		model.addAttribute("pageCnt",empVO.getPageCnt());
		model.addAttribute("viewCnt",empVO.getViewCnt());
		model.addAttribute("empVO",empVO);
		if(searchType==null) {
			searchType= "ID";
		}
		
		
		model.addAttribute("searchType",searchType);
		List<DepVO> depList = depService.readAllDepVO(deptSearchVO);
		
		model.addAttribute("depList", depList);
		model.addAttribute("depVO", deptSearchVO);
		
		if (!depList.isEmpty()) {
			model.addAttribute("lastPage", depList.get(0).getLastPage());
		}
		model.addAttribute("pageNo", deptSearchVO.getPageNo());
		model.addAttribute("viewCnt", deptSearchVO.getViewCnt());
		model.addAttribute("pageCnt", deptSearchVO.getPageCnt());
		return "index";
	}
}