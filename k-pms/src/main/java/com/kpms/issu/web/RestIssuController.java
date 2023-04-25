package com.kpms.issu.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.issu.service.IssuService;

@RestController
public class RestIssuController {

	@Autowired
	private IssuService issuService;
}
