package com.kpms.dep.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.kpms.dep.service.DepService;

@Controller
public class DepController {

	@Autowired
	private DepService depService;
}
