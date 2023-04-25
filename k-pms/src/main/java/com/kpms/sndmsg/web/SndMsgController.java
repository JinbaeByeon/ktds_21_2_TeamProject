package com.kpms.sndmsg.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.emp.vo.EmpVO;
import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.sndmsg.service.SndMsgService;
import com.kpms.sndmsg.vo.SndMsgVO;

@Controller
public class SndMsgController {

	@Autowired
	private SndMsgService sndMsgService;
	
	@GetMapping("/sndmsg/list")
	public String viewSndMsgListPage(Model model, MsgSearchVO sndMsgVO, @SessionAttribute("__USER__") EmpVO user, String searchType) {
		sndMsgVO.setEmpId(user.getEmpId());
		List<SndMsgVO> sndMsgList = sndMsgService.readAllSndMsgVO(sndMsgVO);
		
		model.addAttribute("sndMsgList", sndMsgList);
		model.addAttribute("sndMsgVO", sndMsgVO);
		if(!sndMsgList.isEmpty()) {
			model.addAttribute("lastPage",sndMsgList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",sndMsgVO.getPageNo());
		model.addAttribute("pageCnt",sndMsgVO.getPageCnt());
		model.addAttribute("viewCnt",sndMsgVO.getViewCnt());
		
		if(searchType == null) {
			searchType = "ID";
		}
		model.addAttribute("searchType", searchType);
		
		return "sndmsg/list";
	} 

	@GetMapping("/sndmsg/send") // 이게필요한지
	public String viewMsgSndPage(Model model, SndMsgVO sndMsgVO) {
		
		return "sndmsg/send";
	}
}
