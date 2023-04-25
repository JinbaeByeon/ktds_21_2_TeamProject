package com.kpms.common.handler;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.kpms.atchfl.dao.AtchFlDAO;
import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.vo.AbstractFileVO;

@Component
public class UploadHandler {
	
	private static final Logger logger = LoggerFactory.getLogger(UploadHandler.class);
	@Autowired
//	private FileDAO fileDAO;
	private AtchFlDAO atchFlDAO;
	
	@Value("${upload.profile.path:C:/kpms/files/profiles}")
	private String profilePath;
	
	@Value("${upload.attchmnt.path:/kpms/files/attchmnt}")
	private String atchmntPath;

	@Value("${upload.path:C:/kpms/files}")
	private String uploadPath;
	
	public String getUploadPath() {
		return uploadPath;
	}
	
	public void upload(List<MultipartFile> fileList,int boardId) {
		fileList.forEach(file ->uploadFile(file,boardId));
	}
	
	public void uploadFile(MultipartFile file, int voId) {
		if(file != null && !file.isEmpty()) {
			String fileName = UUID.randomUUID().toString();
			
			File uploadDir = new File(uploadPath);
			if(!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
			
			try {
				file.transferTo(new File(uploadPath,fileName));
			} catch (IllegalStateException | IOException e) {
				logger.error(e.getMessage(),e);
				throw new RuntimeException(e.getMessage(),e);
			}
			
		}
	}
	
	
	public void uploadProfile(MultipartFile file, AbstractFileVO vo) {
		if(file != null && !file.isEmpty()) {
			String fileName = UUID.randomUUID().toString();
			
			File uploadDir = new File(profilePath);
			if(!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
			
			try {
				file.transferTo(new File(profilePath,fileName));
			} catch (IllegalStateException | IOException e) {
				throw new RuntimeException(e.getMessage(),e);
			}
			vo.setFileName(fileName);
		}
	}
	
	public void uploadMultiAtchmnt(List<MultipartFile> fileList, String knwId) {
		fileList.forEach(file ->uploadAtchmnt(file, knwId));
	}
	
	public void uploadAtchmnt(MultipartFile file, String knwId) {
		if(file != null && !file.isEmpty()) {
			String fileName = UUID.randomUUID().toString();
			String originFileName = file.getOriginalFilename();
			
			File uploadDir = new File(atchmntPath);
			if(!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
			
			try {
				file.transferTo(new File(atchmntPath, fileName));
			} catch (IllegalStateException | IOException e) {
				throw new RuntimeException(e.getMessage(),e);
			}

			AtchFlVO fileVO = new AtchFlVO();
			fileVO.setFrgnId(knwId);
			fileVO.setOrgFlNm(originFileName);
			fileVO.setUuidFlNm(fileName);
			fileVO.setFlSz(file.getSize());
			
			String ext = originFileName.substring(originFileName.lastIndexOf(".") + 1);
			fileVO.setFlExt(ext);
			
			atchFlDAO.doCreateNewAtchFl(fileVO);
		}
	}
	
}
