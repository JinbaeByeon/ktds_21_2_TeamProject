package com.kpms.rcvmsg.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.rcvmsg.service.RcvMsgService;
import com.kpms.rcvmsg.vo.RcvMsgVO;

@Controller
public class RcvMsgController {

	@Autowired
	private RcvMsgService rcvMsgService;
	
	@GetMapping("/rcvmsg/list")
	public String viewRcvMsgListPage(Model model, RcvMsgVO rcvMsgVO) {
		List<RcvMsgVO> rcvMsgList = rcvMsgService.readAllRcvMsgVO(rcvMsgVO);
		
		model.addAttribute("rcvMsgList", rcvMsgList);
		model.addAttribute("rcvMsgVO", rcvMsgVO);
		
		return "rcvmsg/list";
	}
}
