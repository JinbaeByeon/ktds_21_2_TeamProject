package com.kpms.atchfl.web;

import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.atchfl.vo.AtchFlVOList;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIException;
import com.kpms.common.handler.DownloadUtil;

@Controller
public class AtchFlController {
	private static final Logger logger = LoggerFactory.getLogger(AtchFlController.class);

	@Value("${upload.attchmnt.path:/kpms/files/attchmnt}")
	private String atchmntPath;
	
	@GetMapping("/api/file/download")
	public void downloadFile(AtchFlVO atchFlVO
				, HttpServletRequest request
				, HttpServletResponse response) {
		String uuidNm = atchFlVO.getUuidFlNm();
		String fileNm = atchFlVO.getOrgFlNm();
		System.out.println(uuidNm +" - " + fileNm);
		try {
			new DownloadUtil(response,request,atchmntPath + "/" + uuidNm)
			.download(fileNm);
		} catch (RuntimeException e) {
			throw new APIException(APIStatus.NOT_FOUND, "파일을 찾을 수 없습니다.");
		}
	}
	
	@PostMapping("/api/files/download")
	public void downloadFile(AtchFlVOList atchFlVOList
				, String fileNm
				, HttpServletRequest request
				, HttpServletResponse response) {
		response.setContentType("application/zip");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileNm + ".zip");
		
		try(ZipOutputStream zipOutputStream = new ZipOutputStream(response.getOutputStream())) {
			for(AtchFlVO atchFlVO : atchFlVOList.getAtchFlVOList()) {
				String uuidNm = atchFlVO.getUuidFlNm();
				String filePath = atchmntPath + "/" + uuidNm;
				FileSystemResource fileSystemResource = new FileSystemResource(filePath);
				/* ZipEntry zipEntry = new ZipEntry(fileSystemResource.getFilename()); */
				ZipEntry zipEntry = new ZipEntry(atchFlVO.getOrgFlNm());
				zipEntry.setSize(fileSystemResource.contentLength());
				zipEntry.setTime(System.currentTimeMillis());
				
				zipOutputStream.putNextEntry(zipEntry);
				
				StreamUtils.copy(fileSystemResource.getInputStream(), zipOutputStream);
				zipOutputStream.closeEntry();
			}
			zipOutputStream.finish();
		} catch(IOException e) {
			logger.error(e.getMessage(),e);
		}
	}
	
}
