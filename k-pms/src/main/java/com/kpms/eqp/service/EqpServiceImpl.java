package com.kpms.eqp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.emp.vo.EmpVO;
import com.kpms.eqp.dao.EqpDAO;
import com.kpms.eqp.vo.EqpVO;

@Service
public class EqpServiceImpl implements EqpService{
	
	@Autowired
	private EqpDAO eqpDAO;
	
	@Override
	public boolean createNewEqp(EqpVO eqpVO) {
		return eqpDAO.createNewEqp(eqpVO) > 0;
	}

	@Override
	public List<EqpVO> readAllEqp(EqpVO eqpVO) {
		return eqpDAO.readAllEqp(eqpVO);
	}

	@Override
	public List<EqpVO> readAllEqpNoPagination(String eqpNm) {
		return eqpDAO.readAllEqpNoPagination(eqpNm);
	}
	
	@Override
	public boolean updateEqp(EqpVO eqpVO) {
		return eqpDAO.updateEqp(eqpVO) > 0;
	}

	@Override
	public boolean deleteEqpByEqpId(String eqpId) {
		return eqpDAO.deleteEqpByEqpId(eqpId) > 0;
	}

	@Override
	public boolean deleteEqpBySelectedEqpId(List<String> eqpId) {
		return eqpDAO.deleteEqpBySelectedEqpId(eqpId) > 0;
	}


	@Override
	public boolean applyEqp(List<String> eqpId, EmpVO empVO, String action) {
		
		int applyCount = 0;
		List<EqpVO> eqpVO = eqpDAO.readEqpByEqpId(eqpId);
		for (EqpVO eqpVO2 : eqpVO) {
			
			String applStts = eqpVO2.getApplStts();
			if(action.equals("apply")) {
				if(applStts == null || applStts.equals("")) {
					eqpVO2.setApplId(empVO.getEmpId());
					eqpVO2.setApplStts("대여신청");
				}
				else if(applStts.equals("대여신청")) {
					eqpVO2.setApplStts("대여승인");
				}
				else if(applStts.equals("반납신청")) {
					eqpVO2.setApplStts("반납승인");
				}
				else if(applStts.equals("변경신청")) {
					eqpVO2.setApplStts("변경승인");
				}
			}
			else if(action.equals("refuse")) {
				if(applStts.equals("대여신청")) {
					eqpVO2.setApplStts("대여신청반려");
				}
				else if(applStts.equals("반납신청")) {
					eqpVO2.setApplStts("반납신청반려");
				}
				else if(applStts.equals("변경신청")) {
					eqpVO2.setApplStts("변경신청반려");
				}
			}
			applyCount += eqpDAO.applyEqp(eqpVO2);
		}
		
		
		return applyCount > 0;
	}



	

}
