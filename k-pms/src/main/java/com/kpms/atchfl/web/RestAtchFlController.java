package com.kpms.atchfl.web;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.api.vo.APIDataResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.handler.UploadHandler;

@RestController
public class RestAtchFlController {

	@Autowired
	private UploadHandler uploadHandler;
	
	@PostMapping("/api/atchfl/upload")
	public APIDataResponseVO doUploadFiles(@RequestParam MultipartFile[] uploadFile) {
		
		List<AtchFlVO> fileList = uploadHandler.uploadMultiAtchmnt(Arrays.asList(uploadFile), null);
		
		return new APIDataResponseVO(APIStatus.OK, fileList);
	}
	
	@PostMapping("/api/atchfl/delete")
	public void doDeleteFiles(@RequestParam String[] fileNames) {
		System.out.println(fileNames.length);
		uploadHandler.deleteUploadFiles(Arrays.asList(fileNames));
	}
}
