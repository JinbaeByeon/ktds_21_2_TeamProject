package com.kpms.lgnhst.web;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.excel4j.write.ExcelWrite;
import com.kpms.common.exception.APIException;
import com.kpms.common.handler.DownloadUtil;
import com.kpms.common.util.ExcelUtil;
import com.kpms.lgnhst.service.LgnHstService;
import com.kpms.lgnhst.vo.LgnHstExcelVO;
import com.kpms.lgnhst.vo.LgnHstVO;

@Controller
public class LgnHstController {

	@Autowired
	private LgnHstService lgnHstService;
	
	@GetMapping("/emp/log/lgn")
	public String readLgnHst(Model model,LgnHstVO lgnHstVO,String searchType) {
		List<LgnHstVO> lgnHstList = lgnHstService.readAllLgnHst(lgnHstVO);
		model.addAttribute("lgnHstList",lgnHstList);
		if(!lgnHstList.isEmpty()) {
			model.addAttribute("lastPage",lgnHstList.get(0).getLastPage());
		}
		model.addAttribute("empId",lgnHstVO.getCrtr());
		model.addAttribute("pageNo",lgnHstVO.getPageNo());
		model.addAttribute("pageCnt",lgnHstVO.getPageCnt());
		model.addAttribute("viewCnt",lgnHstVO.getViewCnt());
		if(searchType==null) {
			searchType= "ID";
		}
		model.addAttribute("searchType",searchType);
		if(searchType.equals("ID")) {
			model.addAttribute("searchKeyword",lgnHstVO.getCrtr());
		}
		else if(searchType.equals("이름")) {
			model.addAttribute("searchKeyword",lgnHstVO.getEmp().getfNm());
		}
		return "emp/log/lgn";
	}

	@GetMapping("/lgnlog/export/excel")
	public void doExportExcelEmp(LgnHstVO lgnHstVO
								, HttpServletRequest request
								, HttpServletResponse response) {
		List<LgnHstExcelVO> contents = lgnHstService.readAllLgnHstToExcel(lgnHstVO);
		String path = "C:/kpms/files/excel";
		String fileName = "LgnLogs.xlsx";
		File excelFile = ExcelUtil.writeExcel(contents, fileName, path);
		if(!excelFile.exists()) {
			throw new APIException(APIStatus.FAIL, "엑셀 추출을 실패하였습니다.");
		}
		else {
			path = excelFile.getPath();
			new DownloadUtil(response, request, path)
			.download(fileName);
		}
	}
}