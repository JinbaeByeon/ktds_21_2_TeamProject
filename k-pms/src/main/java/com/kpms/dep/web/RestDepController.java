package com.kpms.dep.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.dep.service.DepService;

@RestController
public class RestDepController {

	@Autowired
	private DepService depService;

}
