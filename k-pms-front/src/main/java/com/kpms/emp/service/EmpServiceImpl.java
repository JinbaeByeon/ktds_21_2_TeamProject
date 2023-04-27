package com.kpms.emp.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.common.handler.SessionHandler;
import com.kpms.common.handler.UploadHandler;
import com.kpms.common.service.MailService;
import com.kpms.common.util.CalendarUtil;
import com.kpms.common.util.SHA256Util;
import com.kpms.common.util.StringUtil;
import com.kpms.common.vo.MailVO;
import com.kpms.emp.dao.EmpDAO;
import com.kpms.emp.vo.EmpPwdVO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.lgnhst.dao.LgnHstDAO;
import com.kpms.lgnhst.vo.LgnHstVO;
import com.kpms.lgntrylog.dao.LgnTryLogDAO;

@Service
public class EmpServiceImpl implements EmpService {
	@Autowired
	private EmpDAO empDAO;
	@Autowired
	private LgnHstDAO lgnHstDAO;
	@Autowired
	private LgnTryLogDAO lgnTryLogDAO;
	@Autowired
	UploadHandler uploadHandler;
	@Autowired
	MailService mailService;
	
	@Override
	public boolean createOneEmp(EmpVO empVO, MultipartFile uploadFile) {
		
		if(empDAO.readOneEmpByEmpId(empVO.getEmpId()) != null) {
			throw new APIException(APIStatus.FAIL, "이미 사용중인 ID입니다.");
		}
		if (StringUtil.isEmpty(empVO.getfNm())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "이름은 필수 값입니다.");
		}
		if (StringUtil.isExceedLength(empVO.getfNm(), 30)) {
			throw new APIArgsException(APIStatus.OVER_LEN_ARG, "이름은 30글자까지 입력할 수 있습니다.");
		}
		
		if (StringUtil.isEmpty(empVO.getEmpId())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "ID는 필수 값입니다.");
		}
		if (StringUtil.isExceedLength(empVO.getEmpId(), 20)) {
			throw new APIArgsException(APIStatus.OVER_LEN_ARG, "ID는 20글자까지 입력할 수 있습니다.");
		}
		
		if (StringUtil.isEmpty(empVO.getEml())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "이메일은 필수 값입니다.");
		}
		if (StringUtil.isExceedLength(empVO.getEml(), 50)) {
			throw new APIArgsException(APIStatus.OVER_LEN_ARG, "이메일은 50글자까지 입력할 수 있습니다.");
		}
		
		// 핸드폰
		if(StringUtil.isEmpty(empVO.getPhn())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "휴대폰 번호는 필수 값입니다.");
		}
		if(!empVO.getPhn().matches("^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$")) {
			throw new APIArgsException(APIStatus.DISMATCH, "휴대폰 번호의 형식이 일치하지 않습니다.");
		}
		
		// 주소
		if(StringUtil.isEmpty(empVO.getAddrss())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "주소는 필수 값입니다.");
		}
		// 생년월일
		if(StringUtil.isEmpty(empVO.getBrthdy())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "생년월일은 필수 값입니다.");
		}
		
		uploadHandler.uploadProfile(uploadFile, empVO);
		empVO.setPrflPht(empVO.getFileName());
		
		String randomPwd = StringUtil.getRandomPassword(10);
		
		MailVO mailVO = new MailVO();
		mailVO.setFrom("ktds21b@gmail.com");
		mailVO.setTo(empVO.getEml());
		mailVO.setSubject("KPMS 로그인 비밀번호 발송");
		
		String content = "아이디: " +empVO.getEmpId() +"\n";
		content +="비밀번호: " +randomPwd;
		mailVO.setContent(content);
		mailService.sendMail(mailVO);
		
		String salt = SHA256Util.generateSalt();
		empVO.setPwdSalt(salt);
		randomPwd = SHA256Util.getEncrypt(randomPwd, salt);
		empVO.setPwd(randomPwd);
		
		return empDAO.createOneEmp(empVO) > 0;
	}

	@Override
	public boolean readPwdChngDtMore90ById(String empId) {
		return empDAO.readCntPwdChngDtMore90ById(empId) > 0;
	}
	
	@Override
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO) {
		String empId = empVO.getEmpId();
		if(StringUtil.isEmpty(empVO.getEmpId())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "ID를 입력하세요.");
		}
		if(StringUtil.isEmpty(empVO.getPwd())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "비밀번호를 입력하세요.");
		}
		
		String salt = empDAO.readSaltById(empId);
		empVO.setPwd(SHA256Util.getEncrypt(empVO.getPwd(), salt));
		
		EmpVO lgnTryData = empDAO.readLgnTryDataById(empId);
		if(lgnTryData == null) {
			throw new APIException(APIStatus.DISMATCH, "아이디 또는 비밀번호가 일치하지 않습니다.");
		} else if(lgnTryData.getLgnCnt() >= 5) {
			if(empDAO.readCntLgnTryDataRcnt60ById(empId) == 0) {
				empDAO.updateEmpLgnCntZero(empId);
			} else {
				String unLockTm = CalendarUtil.getDate(lgnTryData.getFailDt(), Calendar.HOUR, 1).substring(10,19);
				throw new APIException(APIStatus.FAIL, unLockTm + " 이후 다시 시도해주세요.");
			}
		}
		
		EmpVO loginData = empDAO.readOneEmpByIdAndPwd(empVO);
		if(loginData == null) {
			// 로그인 실패
			// 로그인 시도 회수 증가
			empDAO.updateEmpLgnFail(empId);
			// 로그인 시도 이력 추가
			lgnTryLogDAO.createLgnTryLog(empVO);
		} else {
			// 로그인 성공
			if(SessionHandler.get().isAlreadyLogin(empVO.getEmpId())) {
				throw new APIException(APIStatus.FAIL, "이미 로그인된 ID입니다.");
			}
			if(loginData.getEmplmntStts().equals("휴직중")) {
				throw new APIException(APIStatus.FAIL, "휴직 사원입니다.");
			} else if(loginData.getEmplmntStts().equals("퇴사예정")) {
				throw new APIException(APIStatus.FAIL, "퇴사예정 사원입니다.");
			} else if(loginData.getEmplmntStts().equals("퇴사")) {
				throw new APIException(APIStatus.FAIL, "퇴사 사원입니다.");
			}
			
			// emp 테이블 로그인 데이터 수정
			empDAO.updateEmpLgnSucc(empVO);
			// 로그인 이력 추가
			LgnHstVO lgnHstVO = new LgnHstVO();
			lgnHstVO.setCrtr(empId);
			lgnHstVO.setAct("login");
			lgnHstVO.setIp(empVO.getLtstLgnIp());
			lgnHstDAO.createEmpLgnHst(lgnHstVO);
		}

		
		return loginData;
	}

	@Override
	public EmpVO readOneEmpByEmpId(String empId) {
		return empDAO.readOneEmpByEmpId(empId);
	}

	@Override
	public List<EmpVO> readEmpListNoPagination(EmpVO empVO) {
		return empDAO.readEmpListNoPagination(empVO);
	}
	@Override
	public List<EmpVO> readEmpList(EmpVO empVO) {
		return empDAO.readEmpList(empVO);
	}

	@Override
	public boolean updateOneEmp(EmpVO empVO, MultipartFile uploadFile) {
		if (StringUtil.isEmpty(empVO.getfNm())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "이름은 필수 값입니다.");
		}
		if (StringUtil.isExceedLength(empVO.getfNm(), 30)) {
			throw new APIArgsException(APIStatus.OVER_LEN_ARG, "이름은 30글자까지 입력할 수 있습니다.");
		}
		
		if (StringUtil.isEmpty(empVO.getEmpId())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "ID는 필수 값입니다.");
		}
		if (StringUtil.isExceedLength(empVO.getEmpId(), 10)) {
			throw new APIArgsException(APIStatus.OVER_LEN_ARG, "ID는 10글자까지 입력할 수 있습니다.");
		}
		
		if (StringUtil.isEmpty(empVO.getEml())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "이메일은 필수 값입니다.");
		}
		if (StringUtil.isExceedLength(empVO.getEml(), 50)) {
			throw new APIArgsException(APIStatus.OVER_LEN_ARG, "이메일은 50글자까지 입력할 수 있습니다.");
		}
		
		// 핸드폰
		if(StringUtil.isEmpty(empVO.getPhn())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "휴대폰 번호는 필수 값입니다.");
		}
		if(!empVO.getPhn().matches("^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$")) {
			throw new APIArgsException(APIStatus.DISMATCH, "휴대폰 번호의 형식이 일치하지 않습니다.");
		}
		
		// 주소
		if(StringUtil.isEmpty(empVO.getAddrss())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "주소는 필수 값입니다.");
		}
		// 생년월일
		if(StringUtil.isEmpty(empVO.getBrthdy())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "생년월일은 필수 값입니다.");
		}
		
		uploadHandler.uploadProfile(uploadFile, empVO);
		empVO.setPrflPht(empVO.getFileName());
				
		return empDAO.updateOneEmp(empVO) > 0;
	}

	@Override
	public boolean updateEmpPwd(EmpPwdVO empPwdVO) {
		String empId = empPwdVO.getEmpId();
		String pwd = empPwdVO.getPwd();
		String newPwd = empPwdVO.getNewPwd();
		String newPwdCnfrm = empPwdVO.getNewPwdCnfrm();
		EmpVO empVO = new EmpVO();
		empVO.setEmpId(empId);
		empVO.setMdfyr(empId);
		
		String salt = empDAO.readSaltById(empId);
		empVO.setPwd(SHA256Util.getEncrypt(pwd, salt));
		
		if(empDAO.readOneEmpByIdAndPwd(empVO) == null) {
			throw new APIArgsException(APIStatus.DISMATCH, "현재 비밀번호 값이 일치하지 않습니다.");
		}
		if(newPwd.length() < 10) {
			throw new APIArgsException(APIStatus.FAIL, "비밀번호의 길이가 10자 미만입니다.");
		}
		if(!newPwd.matches("^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[$@$!%*#?&])[A-Za-z[0-9]$@$!%*#?&]{10,20}$")) {
			throw new APIArgsException(APIStatus.FAIL, "비밀번호는 10글자 이상의 영문자, 특수문자, 숫자를 포함한 값이어야 합니다.");
		}
		if(!StringUtil.isMatchTo(newPwd, newPwdCnfrm)) {
			throw new APIArgsException(APIStatus.DISMATCH, "비밀번호 확인 값이 일치하지 않습니다.");
		}
		
		salt = SHA256Util.generateSalt();
		empVO.setPwdSalt(salt);
		newPwd = SHA256Util.getEncrypt(newPwd, salt);
		empVO.setPwd(newPwd);
		return empDAO.updateOneEmp(empVO) > 0;
	}
	@Override
	public boolean updateEmpPwdReset(List<String> empIdList, String mdfyr) {
		int cntUpdate = 0;
		for(String empId : empIdList) {
			if(empDAO.readOneEmpByEmpId(empId)==null) {
				throw new APIArgsException(APIStatus.DISMATCH, "일치하는 ID가 존재하지 않습니다.");
			}
			EmpVO empVO = new EmpVO();
			empVO.setEmpId(empId);
			
			String randomPwd = StringUtil.getRandomPassword(10);
			
			MailVO mailVO = new MailVO();
			mailVO.setFrom("ktds21b@gmail.com");
			mailVO.setTo(empVO.getEml());
			mailVO.setSubject("KPMS 로그인 비밀번호 발송 메일입니다.");
			
			String content = "아이디: " +empVO.getEmpId() +"\n";
			content +="비밀번호: " +randomPwd;
			mailVO.setContent(content);
			mailService.sendMail(mailVO);
			
			String salt = SHA256Util.generateSalt();
			empVO.setPwdSalt(salt);
			randomPwd = SHA256Util.getEncrypt(randomPwd, salt);
			empVO.setPwd(randomPwd);
			cntUpdate += empDAO.updateOneEmp(empVO);
		}
		return cntUpdate > 0;
	}
	
	@Override
	public boolean deleteOneEmp(EmpVO empVO) {
		return empDAO.deleteOneEmp(empVO) > 0;
	}

	@Override
	public boolean createLgnHst(LgnHstVO lgnHst) {
		return lgnHstDAO.createEmpLgnHst(lgnHst) > 0;
	}
	@Override
	public String readSaltById(String empId) {
		return empDAO.readSaltById(empId);
	}
	
}
