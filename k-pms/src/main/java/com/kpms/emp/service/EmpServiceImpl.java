package com.kpms.emp.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.exception.APIException;
import com.kpms.common.util.CalendarUtil;
import com.kpms.common.util.SHA256Util;
import com.kpms.common.util.StringUtil;
import com.kpms.emp.dao.EmpDAO;
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
	
	
	@Override
	public boolean createOneEmp(EmpVO empVO) {
		
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
		
		String defaultPwd = empVO.getEmpId();
		String salt = SHA256Util.generateSalt();
		empVO.setPwdSalt(salt);
		defaultPwd = SHA256Util.getEncrypt(defaultPwd, salt);
		empVO.setPwd(defaultPwd);
		
		return empDAO.createOneEmp(empVO) > 0;
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
	public List<EmpVO> readEmpList(EmpVO empVO) {
		return empDAO.readEmpList(empVO);
	}

	@Override
	public boolean updateOneEmp(EmpVO empVO) {
		return empDAO.updateOneEmp(empVO) > 0;
	}

	@Override
	public boolean deleteOneEmp(EmpVO empVO) {
		return empDAO.deleteOneEmp(empVO) > 0;
	}

	@Override
	public boolean createLgnHst(LgnHstVO lgnHst) {
		return lgnHstDAO.createEmpLgnHst(lgnHst) > 0;
	}
}
