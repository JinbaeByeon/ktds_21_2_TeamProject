package com.kpms.emp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.common.api.vo.APIStatus;
import com.kpms.common.exception.APIArgsException;
import com.kpms.common.util.StringUtil;
import com.kpms.emp.dao.EmpDAO;
import com.kpms.emp.vo.EmpVO;

@Service
public class EmpServiceImpl implements EmpService {
	@Autowired
	private EmpDAO empDAO;

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
		if(!empVO.getPhn().matches("^0[0-9]{,2}-[0-9]{3,4}-[0-9]{,4}")) {
			throw new APIArgsException(APIStatus.INCORRECT, "휴대폰 번호의 형식이 일치하지 않습니다.");
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
			throw new APIArgsException(APIStatus.INCORRECT, "확인값이 비밀번호와 일치하지 않습니다.");
		}
		
		return empDAO.createOneEmp(empVO) > 0;
	}

	@Override
	public EmpVO readOneEmpByIdAndPwd(EmpVO empVO) {
		return empDAO.readOneEmpByIdAndPwd(empVO);
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
}
