package com.kpms.acslog.web;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.acslog.service.AcsLogService;
import com.kpms.acslog.vo.AcsLogExcelVO;
import com.kpms.acslog.vo.AcsLogVO;
import com.kpms.common.handler.DownloadUtil;
import com.kpms.common.util.ExcelUtil;

@Controller
public class AcsLogController {

	@Autowired
	private AcsLogService acsLogService;
	
	@GetMapping("/emp/log/acs")
	public String viewAcsLogPage(Model model, AcsLogVO acsLogVO,String searchType) {
		List<AcsLogVO> acsLogList = acsLogService.readAllAcsLog(acsLogVO);
		model.addAttribute("acsLogList",acsLogList);
		if(!acsLogList.isEmpty()) {
			model.addAttribute("lastPage",acsLogList.get(0).getLastPage());
		}
		model.addAttribute("acsLogVO",acsLogVO);
		model.addAttribute("viewCnt",acsLogVO.getViewCnt());
		model.addAttribute("pageCnt",acsLogVO.getPageCnt());
		model.addAttribute("pageNo",acsLogVO.getPageNo());
		if(searchType==null) {
			searchType= "ID";
		}
		model.addAttribute("searchType",searchType);
		if(searchType.equals("ID")) {
			model.addAttribute("searchKeyword",acsLogVO.getCrtr());
		}
		else if(searchType.equals("이름")) {
			model.addAttribute("searchKeyword",acsLogVO.getEmp().getfNm());
		}
		return "emp/log/acs";
	}

	@GetMapping("/acslog/export/excel")
	public void doExportExcelEmp(AcsLogVO acsLogVO
								, HttpServletRequest request
								, HttpServletResponse response) {
		List<AcsLogExcelVO> contents = acsLogService.readAllAcsLogToExcel(acsLogVO);
		String path = "C:/kpms/files/excel";
		String fileName = "AcsLogs.xlsx";
		File excelFile = ExcelUtil.writeExcel(contents, fileName, path);
		
		if(excelFile.exists()) {
			path = excelFile.getPath();
			new DownloadUtil(response, request, path)
			.download(fileName);
		}
	}
}
