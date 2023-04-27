package com.kpms.sndmsg.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.sndmsg.service.SndMsgService;
import com.kpms.sndmsg.vo.SndMsgVO;

@Controller
public class SndMsgController {

	@Autowired
	private SndMsgService sndMsgService;
	
	@GetMapping("/sndmsg/list")
	public String viewSndMsgListPage(Model model, SndMsgVO sndMsgVO, String searchRcvr) {
		List<SndMsgVO> sndMsgList = sndMsgService.readAllSndMsgVO(sndMsgVO);
		
		model.addAttribute("sndMsgList", sndMsgList);
		model.addAttribute("sndMsgVO", sndMsgVO);
		model.addAttribute("searchRcvr", searchRcvr);
		
		return "sndmsg/list";
	}
}
