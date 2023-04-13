package com.kpms.emp.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.emp.service.EmpService;
import com.kpms.emp.vo.EmpVO;
import com.kpms.lgnhst.vo.LgnHstVO;

@Controller
public class EmpController {

	@Autowired
	private EmpService empService;
	
	@GetMapping("/")
	public String viewLgnPage() {
		return "emp/lgn";
	}

	@GetMapping("/emp/lgt")
	public String doLogoutEmp(HttpSession session, HttpServletRequest request) {
		EmpVO user = (EmpVO)session.getAttribute("__USER__");
		LgnHstVO lgnHst = new LgnHstVO();
		lgnHst.setAct("logout");
		lgnHst.setCrtr(user.getEmpId());
		lgnHst.setIp(request.getRemoteAddr());
		session.invalidate();
		empService.createLgnHst(lgnHst);
		return "redirect:/";
	}
	
	@GetMapping("/emp/list")
	public String viewEmpListPage() {
		
		return "emp/list";
	}
	
	@GetMapping("/emp/admin/list")
	public String viewAdminListPage() {
		
		return "emp/adminList";
	}
}
