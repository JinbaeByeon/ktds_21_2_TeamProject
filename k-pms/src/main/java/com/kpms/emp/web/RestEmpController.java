package com.kpms.emp.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.emp.service.EmpService;

@RestController
public class RestEmpController {

	@Autowired
	private EmpService empService;
}
