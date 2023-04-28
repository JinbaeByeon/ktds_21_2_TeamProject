package com.kpms.sndmsg.web;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.api.vo.APIDataResponseVO;
import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.handler.UploadHandler;
import com.kpms.sndmsg.service.SndMsgService;
import com.kpms.sndmsg.vo.SndMsgVO;

@RestController
public class RestSndMsgController {

	@Autowired
	private SndMsgService sndMsgService;
	@Autowired
	private UploadHandler uploadHandler;
	
	@PostMapping("/api/sndmsg/snd")
	public APIResponseVO doSndMsg(SndMsgVO sndMsgVO) {
		if(sndMsgService.createOneSndMsg(sndMsgVO)) {
			return new APIResponseVO(APIStatus.OK, "/sndmsg/list");
		}
		return new APIResponseVO(APIStatus.FAIL);
	}
	@PostMapping("/api/sndmsg/delete")
	public APIResponseVO doDeleteRcvMsgBySelectedMsgId(@RequestParam List<String> sndMsgIdList) {
		boolean deleteResult = sndMsgService.deleteSndMsgBySelectedMsgId(sndMsgIdList);

		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		} else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	@PostMapping("/api/sndmsg/upload")
	public APIDataResponseVO doUploadFiles(@RequestParam MultipartFile[] uploadFile) {
		
		List<AtchFlVO> fileList = uploadHandler.uploadMultiAtchmnt(Arrays.asList(uploadFile), null);
		
		return new APIDataResponseVO(APIStatus.OK, fileList);
	}
	
	@PostMapping("/api/sndmsg/delete/file")
	public void doDeleteFiles(@RequestParam String[] fileNames) {
		System.out.println(fileNames.length);
		uploadHandler.deleteUploadFiles(Arrays.asList(fileNames));
	}
}
