package com.kpms.common.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.dep.service.DepService;
import com.kpms.dep.vo.DepVO;
import com.kpms.dep.vo.DeptSearchVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.prj.service.PrjService;
import com.kpms.prj.vo.PrjSearchVO;
import com.kpms.prj.vo.PrjVO;
import com.kpms.tm.service.TmService;
import com.kpms.tm.vo.TmSearchVO;
import com.kpms.tm.vo.TmVO;

@Controller
public class IndexController {
	
	@Autowired
	private DepService depService;
	
	@Autowired
	private TmService tmService;
	
	@Autowired
	private PrjService prjService;

	@GetMapping("/index")
	public String viewIndexPage(PrjSearchVO prjSearchVO, @SessionAttribute("__USER__")EmpVO empVO, Model model) {

		prjSearchVO.setEmpId(empVO.getEmpId());

		List<PrjVO> prjList = prjService.readAllPrjVO(prjSearchVO);

		model.addAttribute("prjList", prjList);
		
		var empId = empVO.getEmpId();
		DepVO depVO = depService.readOneDepVOByDepId(empId);
		if(depVO.getTmList().get(0).getTmId()== null) {
			depVO.setTmList(null);
		}
		model.addAttribute("depVO", depVO);
		return "index";
	}
}