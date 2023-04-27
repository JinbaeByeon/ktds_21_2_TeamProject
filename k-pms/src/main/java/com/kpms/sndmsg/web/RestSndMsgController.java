package com.kpms.sndmsg.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.sndmsg.service.SndMsgService;
import com.kpms.sndmsg.vo.SndMsgVO;

@RestController
public class RestSndMsgController {

	@Autowired
	private SndMsgService sndMsgService;
	
	@PostMapping("/api/sndmsg/snd")
	public APIResponseVO doSndMsg(SndMsgVO sndMsgVO) {
		if(sndMsgService.createOneSndMsg(sndMsgVO)) {
			return new APIResponseVO(APIStatus.OK, "/sndmsg/list");
		}
		return new APIResponseVO(APIStatus.FAIL);
	}
}
