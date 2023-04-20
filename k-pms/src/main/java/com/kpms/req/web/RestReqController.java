package com.kpms.req.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.req.service.ReqService;

@Controller
public class RestReqController {

	@Autowired
	private ReqService reqService;
	
	@GetMapping("")
	public String viewReqListPage() {
		
		return "";
	}
	
	@GetMapping("")
	public String viewReqCreatePage() {
		
		return "";
	}
	
	@GetMapping("")
	public String viewReqDetailPage() {
		
		return "";
	}
}
