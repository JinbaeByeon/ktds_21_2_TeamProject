package com.kpms.knw.web;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.api.vo.APIDataResponseVO;
import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.handler.DownloadUtil;
import com.kpms.common.handler.UploadHandler;
import com.kpms.emp.vo.EmpVO;
import com.kpms.knw.service.KnwService;
import com.kpms.knw.vo.KnwVO;

@RestController
public class RestKnwController {

	@Autowired
	private KnwService knwService;
	@Autowired
	private UploadHandler uploadHandler;
	@Value("${upload.attchmnt.path:/kpms/files/attchmnt}")
	private String atchmntPath;

	@PostMapping("/api/knw/create")
	public APIResponseVO doCreateKnw(KnwVO knwVO, @SessionAttribute("__USER__") EmpVO empVO) {
		knwVO.setCrtr(empVO.getEmpId());
		knwVO.setMdfyr(empVO.getEmpId());
		boolean isSuccess = knwService.createOneKnw(knwVO);

		if (isSuccess) {
			return new APIResponseVO(APIStatus.OK, "/knw/detail/" + knwVO.getKnwId());
		} else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	@PostMapping("/api/knw/update")
	public APIResponseVO doUpdateKnw(KnwVO knwVO, @SessionAttribute("__USER__") EmpVO empVO) {
		knwVO.setMdfyr(empVO.getEmpId());
		boolean isSuccess = knwService.updateOneKnw(knwVO);

		if (isSuccess) {
			return new APIResponseVO(APIStatus.OK, "/knw/detail/" + knwVO.getKnwId());
		} else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	@GetMapping("/api/knw/delete/{knwId}")
	public APIResponseVO doDeleteKnw(@PathVariable String knwId) {
		boolean isSuccess = knwService.deleteOneKnw(knwId);

		if (isSuccess) {
			return new APIResponseVO(APIStatus.OK);
		} else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/knw/delete")
	public APIResponseVO doDeleteKnwBySelectedKnwId(@RequestParam List<String> knwId) {
		boolean isSuccess = knwService.deleteKnwBySelectedKnwId(knwId);

		if (isSuccess) {
			return new APIResponseVO(APIStatus.OK);
		} else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/knw/upload")
	public APIDataResponseVO doUploadFiles(@RequestParam List<MultipartFile> uploadFile) {
		
		List<AtchFlVO> fileList = uploadHandler.uploadMultiAtchmnt(uploadFile, null);
		
		return new APIDataResponseVO(APIStatus.OK, fileList);
	}
	
	@PostMapping("/api/knw/delfiles")
	public void doDeleteFiles(@RequestParam String[] fileNames) {
		System.out.println(fileNames.length);
		uploadHandler.deleteUploadFiles(Arrays.asList(fileNames));
	}
	
	@PostMapping("/api/knw/file")
	public void downloadAtchFl(AtchFlVO file
								, HttpServletRequest request
								, HttpServletResponse response) {
//		File file = new File(atchmntPath, fileNm);
		String path = atchmntPath + "/";
		
//		if(!file.exists() || !file.isFile()) {
//			fileNm = "base_profile.png";
//		}
		String fileNm = file.getUuidFlNm();
		String orgNm = file.getOrgFlNm();
		System.out.println(fileNm);
		
		path += fileNm;
		System.out.println(path);
		System.out.println(orgNm);
		new DownloadUtil(response, request, path).download(orgNm);
	}

}
