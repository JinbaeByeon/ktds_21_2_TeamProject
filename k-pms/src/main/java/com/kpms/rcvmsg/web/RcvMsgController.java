package com.kpms.rcvmsg.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.emp.vo.EmpVO;
import com.kpms.rcvmsg.service.RcvMsgService;
import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.rcvmsg.vo.RcvMsgVO;

@Controller
public class RcvMsgController {

	@Autowired
	private RcvMsgService rcvMsgService;
	
	@GetMapping("/rcvmsg/list")
	public String viewRcvMsgListPage(Model model, MsgSearchVO rcvMsgVO, @SessionAttribute("__USER__") EmpVO user) {
		rcvMsgVO.setEmpId(user.getEmpId());
		List<RcvMsgVO> rcvMsgList = rcvMsgService.readAllRcvMsgVO(rcvMsgVO);
		
		model.addAttribute("rcvMsgList", rcvMsgList);
		model.addAttribute("rcvMsgVO", rcvMsgVO);
		if(!rcvMsgList.isEmpty()) {
			model.addAttribute("lastPage",rcvMsgList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",rcvMsgVO.getPageNo());
		model.addAttribute("pageCnt",rcvMsgVO.getPageCnt());
		model.addAttribute("viewCnt",rcvMsgVO.getViewCnt());
		
		return "rcvmsg/list";
	}
}
