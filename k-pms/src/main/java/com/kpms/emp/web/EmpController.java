package com.kpms.emp.web;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.kpms.common.handler.DownloadUtil;
import com.kpms.common.handler.SessionHandler;
import com.kpms.emp.service.EmpService;
import com.kpms.emp.vo.EmpVO;
import com.kpms.lgnhst.vo.LgnHstVO;
import com.kpms.tmmbr.vo.TmMbrVO;

@Controller
public class EmpController {

	@Autowired
	private EmpService empService;

	@Value("${upload.profile.path:C:/kpms/files/profiles}")
	private String profilePath;
	
	@GetMapping("/")
	public String viewLgnPage() {
		return "emp/lgn";
	}

	@GetMapping("/emp/lgt")
	public String doLogoutEmp(HttpSession session, HttpServletRequest request) {
		EmpVO user = (EmpVO)session.getAttribute("__USER__");
		LgnHstVO lgnHst = new LgnHstVO();
		lgnHst.setAct("logout");
		lgnHst.setCrtr(user.getEmpId());
		lgnHst.setIp(request.getRemoteAddr());
		SessionHandler.get().clearSession(user.getEmpId());
		session.invalidate();
		empService.createLgnHst(lgnHst);
		return "redirect:/";
	}
	
	@GetMapping("/emp/detail/{empId}")
	public String viewEmpDetailPage(@PathVariable String empId, Model model) {
		EmpVO empVO = empService.readOneEmpByEmpId(empId);
		model.addAttribute("empVO", empVO);
		return "emp/detail";
	}
	
	@GetMapping("/emp/list")
	public String viewEmpListPage(Model model, EmpVO empVO, String searchType) {
		List<EmpVO> empList = empService.readEmpList(empVO);
		model.addAttribute("empList",empList);
		if(!empList.isEmpty()) {
			model.addAttribute("lastPage",empList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",empVO.getPageNo());
		model.addAttribute("pageCnt",empVO.getPageCnt());
		model.addAttribute("viewCnt",empVO.getViewCnt());
		model.addAttribute("empVO",empVO);
		if(searchType==null) {
			searchType= "ID";
		}
		model.addAttribute("searchType",searchType);
		return "emp/list";
	}
	
	@GetMapping("/emp/create")
	public String viewEmpCreatePage() {
		return "emp/create";
	}
	
	@GetMapping("/emp/modify/{empId}")
	public String viewEmpModifyPage(@PathVariable String empId, Model model) {
		EmpVO empVO = empService.readOneEmpByEmpId(empId);
		model.addAttribute("empVO",empVO);
		return "emp/modify";
	}
	@GetMapping("/emp/modify/password/{empId}")
	public String viewEmpPwdModifyPage(@PathVariable String empId, Model model) {
		EmpVO empVO = empService.readOneEmpByEmpId(empId);
		model.addAttribute("empVO",empVO);
		return "emp/modifyPwd";
	}

	@GetMapping("/emp/admin/list")
	public String viewAdminListPage(Model model, EmpVO empVO) {
		List<EmpVO> empList = empService.readEmpList(empVO);
		model.addAttribute("empList",empList);
		if(!empList.isEmpty()) {
			model.addAttribute("lastPage",empList.get(0).getLastPage());
		}
		model.addAttribute("pageNo",empVO.getPageNo());
		model.addAttribute("pageCnt",empVO.getPageCnt());
		model.addAttribute("viewCnt",empVO.getViewCnt());
		return "emp/list";
	}

	@GetMapping("/emp/search")
	public String viewSearchEmpPage(Model model, EmpVO empVO) {
		List<EmpVO> empList = empService.readEmpListNoPagination(empVO);
		model.addAttribute("empList",empList);
		model.addAttribute("depId",empVO.getDepId());
		model.addAttribute("fNm",empVO.getfNm());
		
		return "emp/search";
	}
	@GetMapping("/emp/search/head")
	public String viewSearchHeadEmpPage(Model model, EmpVO empVO) {
		List<EmpVO> empList = empService.readEmpListNoPagination(empVO);
		model.addAttribute("empList",empList);
		model.addAttribute("depId",empVO.getDepId());
		model.addAttribute("fNm",empVO.getfNm());
		
		return "emp/searchHd";
	}
	
	@GetMapping("emp/search/mbr")
	public String viewSearchTmMbrPage(Model model, EmpVO empVO) {
		List<EmpVO> empList = empService.readEmpOnTmMbrListNoPagination(empVO);
		model.addAttribute("empList", empList);
		model.addAttribute("depId",empVO.getDepId());
		model.addAttribute("fNm",empVO.getfNm());
		
		return "emp/searchMbr";
	}

	@GetMapping("/emp/prfl/{fileNm}/")
	public void downloadPrflPctr(@PathVariable String fileNm
								, HttpServletRequest request
								, HttpServletResponse response) {
		File imgFile = new File(profilePath, fileNm);
		String path =profilePath + "/";
		if(!imgFile.exists() || !imgFile.isFile()) {
			fileNm = "base_profile.png";
		}
		path += fileNm;
		DownloadUtil dnUtil = new DownloadUtil(response, request, path);
		dnUtil.download(fileNm);
	}
	
}
