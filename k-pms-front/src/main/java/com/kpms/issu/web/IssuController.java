package com.kpms.issu.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.kpms.atchfl.vo.AtchFlVO;
import com.kpms.common.handler.DownloadUtil;
import com.kpms.issu.service.IssuService;
import com.kpms.issu.vo.IssuVO;

@Controller
public class IssuController {

	@Autowired
	private IssuService issuService;

	@Value("${upload.attchmnt.path:/kpms/files/attchmnt}")
	private String atchmntPath;

	
	@GetMapping("/issu/list")
	public String viewIssuListPage(Model model, IssuVO issuVO) {
		List<IssuVO> issuList = issuService.readIssuList(issuVO);
		model.addAttribute("issuList",issuList);
		if(!issuList.isEmpty()) {
			model.addAttribute("lastPage",issuList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",issuVO.getPageNo());
		model.addAttribute("pageCnt",issuVO.getPageCnt());
		model.addAttribute("viewCnt",issuVO.getViewCnt());
		model.addAttribute("empVO",issuVO);
		return "issu/list";
	}
	
	@GetMapping("/issu/create")
	public String viewIssuCreatePage() {
		return "issu/create";
	}
	
	@GetMapping("/issu/create/{reqId}")
	public String viewIssuCreatePageTwo(Model model, @PathVariable String reqId) {
		model.addAttribute("reqId", reqId);
		return "issu/create";
	}
	
	@GetMapping("/issu/detail/{issuId}")
	public String viewIssuDetailPage(Model model, @PathVariable String issuId) {
		IssuVO issuVO = issuService.readOneIssu(issuId);
		model.addAttribute("issuVO",issuVO);
		return "issu/detail";
	}
	
	@GetMapping("/issu/modify/{issuId}")
	public String viewIssuModifyPage(Model model, @PathVariable String issuId) {
		IssuVO issuVO = issuService.readOneIssu(issuId);
		model.addAttribute("issuVO",issuVO);
		return "issu/modify";
	}
	
	@GetMapping("/api/issu/download")
	public void downloadFile(AtchFlVO atchFlVO
				, HttpServletRequest request
				, HttpServletResponse response) {
		String uuidNm = atchFlVO.getUuidFlNm();
		String fileNm = atchFlVO.getOrgFlNm();
		System.out.println(uuidNm +" - " + fileNm);
		new DownloadUtil(response,request,atchmntPath + "/" + uuidNm)
		.download(fileNm);
	}
}
