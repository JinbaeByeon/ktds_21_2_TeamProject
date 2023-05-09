package com.kpms.rcvmsg.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.rcvmsg.service.RcvMsgService;
import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.rcvmsg.vo.RcvMsgVO;
import com.kpms.sndmsg.vo.SndMsgVO;

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

		if(rcvMsgVO.getSearchKeyword() == null) {
			rcvMsgVO.setSearchType("ID");
		}
		model.addAttribute("searchType", rcvMsgVO.getSearchType());
		return "rcvmsg/list";
	}
	
	@GetMapping("/rcvmsg/send")
	public String viewMsgSndPage(Model model,String rcvMsgId) {
		// rcvmsg.msgId -> rcvMsgVO -> sndMsgId -> sndMsgVO;
		SndMsgVO sndMsgVO = rcvMsgService.readOneSndMsgVO(rcvMsgId);
		model.addAttribute("sndMsgVO", sndMsgVO);
		
		return "sndmsg/send";
	}
	
	@GetMapping("/msg/trash") // 이 메소드는요 휴지통 내의 쪽지들을 보여주는 메소드입니다. 근데 보낸쪽지 받은쪽지 전부다
	public String readAllDelMsg(Model model, MsgSearchVO msgSearchVO) {
		
		List<RcvMsgVO> rcvMsgList = rcvMsgService.readAllDelMsg(msgSearchVO);
		model.addAttribute("rcvMsgList", rcvMsgList);
		if(!rcvMsgList.isEmpty()) {
			model.addAttribute("lastPage",rcvMsgList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",msgSearchVO.getPageNo());
		model.addAttribute("pageCnt",msgSearchVO.getPageCnt());
		model.addAttribute("viewCnt",msgSearchVO.getViewCnt());
		return "rcvmsg/trash";
	}
	
	@GetMapping("/rcvmsg/detail/{msgId}")
	public String viewRcvMsgDetailPage(@PathVariable String msgId, Model model) {
		RcvMsgVO rcvMsgVO = rcvMsgService.readOneRcvMsg(msgId);
		model.addAttribute("rcvMsgVO", rcvMsgVO);
		SndMsgVO sndMsgVO = rcvMsgVO.getSndMsgVO();
		model.addAttribute("sndMsgVO",sndMsgVO);
		List<AtchFlVO> fileList = sndMsgVO.getAtchFlList();
		if(fileList != null && !fileList.isEmpty() && fileList.get(0).getUuidFlNm() != null) {
			model.addAttribute("totalCount",fileList.size());
			long fileSize = 0;
			for(AtchFlVO file : fileList) {
				fileSize += file.getFlSz();
			}
			model.addAttribute("totalSize",fileSize);
		}
		return "rcvmsg/detail";
	}
	
}
