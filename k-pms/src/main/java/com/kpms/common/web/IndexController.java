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
import com.kpms.prj.service.PrjService;
import com.kpms.prj.vo.PrjSearchVO;
import com.kpms.prj.vo.PrjVO;

@Controller
public class IndexController {
	
	@Autowired
	private DepService depService;
	@Autowired
	private EmpService empService;
	@Autowired
	private PrjService prjService;
	
	@GetMapping("/index")
	public String viewIndexPage(DeptSearchVO deptSearchVO, Model model, EmpVO empVO, String searchType, PrjSearchVO prjSearchVO) {
		List<PrjVO> prjList = prjService.readAllPrjVO(prjSearchVO);
		model.addAttribute("prjList", prjList);
	    
		List<EmpVO> empList = empService.readEmpList(empVO);
		model.addAttribute("empList",empList);
		
		List<DepVO> depList = depService.readAllDepVO(deptSearchVO);
		model.addAttribute("depList", depList);
		
		return "index";
	}
}