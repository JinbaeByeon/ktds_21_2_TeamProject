package com.kpms.emp.service;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.util.CalendarUtil;
import com.kpms.common.util.StringUtil;
import com.kpms.emp.dao.EmpDAO;
import com.kpms.emp.vo.EmpVO;
import com.kpms.lgnhst.dao.LgnHstDAO;
import com.kpms.lgnhst.vo.LgnHstVO;
import com.kpms.lgntrylog.dao.LgnTryLogDAO;
import com.kpms.lgntrylog.vo.LgnTryLogVO;
import com.kpms.common.exception.APIException;

@Service
public class EmpServiceImpl implements EmpService {
	@Autowired
	private EmpDAO empDAO;
	@Autowired
	private LgnHstDAO lgnHstDAO;
	@Autowired
	private LgnTryLogDAO lgnTryLogDAO;
	
	@Override
	public boolean createOneEmp(EmpVO empVO, String cPwd) {

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
		
		if (StringUtil.isEmpty(empVO.getPwd())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "비밀번호는 필수 값입니다.");
		}
		
		if (StringUtil.isExceedLength(empVO.getlNm(), 10)) {
			throw new APIArgsException(APIStatus.OVER_LEN_ARG, "성은 10글자까지 입력할 수 있습니다.");
		}
		
		if(StringUtil.isEmpty(empVO.getfNm())) {
			throw new APIArgsException(APIStatus.MISSING_ARG, "이름은 필수 값입니다.");
		}
		if (StringUtil.isExceedLength(empVO.getfNm(), 30)) {
			throw new APIArgsException(APIStatus.OVER_LEN_ARG, "이름은 30글자까지 입력할 수 있습니다.");
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
		
		if (!StringUtil.isMatchTo(empVO.getPwd(), cPwd)) {
			throw new APIArgsException(APIStatus.DISMATCH, "확인값이 비밀번호와 일치하지 않습니다.");
		}
		
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
		/*
		 * LgnTryLogVO lgnTryLog = lgnTryLogDAO.readLgnTryLog(empVO);
		 * 
		 * if(lgnTryLog.getLgnTryCnt() >= 5) { Calendar now = Calendar.getInstance();
		 * String nowDt = CalendarUtil.getDate(now); String unLockDt =
		 * CalendarUtil.getDate(lgnTryLog.getLtstLgnTryDt(), Calendar.HOUR, 1); int min
		 * = StringUtil.dateToInt(unLockDt) - StringUtil.dateToInt(nowDt); if(min > 0) {
		 * throw new APIException(APIStatus.FAIL, "계정이 잠겼습니다." + min +
		 * " 분 후에 다시 시도하세요."); } else { lgnTryLog.setLgnTryCnt(0);
		 * lgnTryLogDAO.updateLgnTryLog(lgnTryLog); } }
		 */
		EmpVO loginData = empDAO.readOneEmpByIdAndPwd(empVO);
		/*
		 * if(loginData == null) { lgnTryLog.setLgnTryCnt(lgnTryLog.getLgnTryCnt()+1); }
		 * else { lgnTryLog.setLgnTryCnt(0); LgnHstVO lgnHstVO = new LgnHstVO();
		 * lgnHstVO.setCrtr(empId); lgnHstVO.setAct("login");
		 * lgnHstVO.setIp(empVO.getLtstLgnIp()); lgnHstDAO.createEmpLgnHst(lgnHstVO); }
		 * lgnTryLogDAO.updateLgnTryLog(lgnTryLog);
		 */
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
