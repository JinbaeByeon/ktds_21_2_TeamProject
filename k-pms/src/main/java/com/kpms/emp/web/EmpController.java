package com.kpms.emp.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.emp.service.EmpService;

@Controller
public class EmpController {

	@Autowired
	private EmpService empService;
	
	@GetMapping("/")
	public String viewLgnPage() {
		return "emp/lgn";
	}
	@GetMapping("/emp/list")
	String viewEmpList() {
		return "emp/list";
	}
}
