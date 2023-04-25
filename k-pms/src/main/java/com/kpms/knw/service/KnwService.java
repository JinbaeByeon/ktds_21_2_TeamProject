package com.kpms.knw.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.kpms.knw.vo.KnwSearchVO;
import com.kpms.knw.vo.KnwVO;

public interface KnwService {

	public boolean createOneKnw(KnwVO knwVO, List<MultipartFile> uploadFile);
	public List<KnwVO> readAllKnw(KnwSearchVO knwSearchVO);
	public KnwVO readOneKnwByKnwId(String KnwId);
	public boolean updateOneKnw(KnwVO knwVO, List<MultipartFile> uploadFile);
	public boolean deleteOneKnw(String knwId);
	public boolean deleteKnwBySelectedKnwId(List<String> knwIdList);
}
