package com.kpms.eqp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kpms.emp.vo.EmpVO;
import com.kpms.eqp.dao.EqpDAO;
import com.kpms.eqp.vo.EqpVO;
import com.kpms.eqplog.dao.EqpLogDAO;
import com.kpms.eqplog.vo.EqpLogVO;

@Service
public class EqpServiceImpl implements EqpService{
	
	@Autowired
	private EqpDAO eqpDAO;
	
	@Autowired
	private EqpLogDAO eqpLogDAO;
	
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
		EqpLogVO eqpLogVO = new EqpLogVO();
		for (EqpVO eqpVO2 : eqpVO) {
			String applStts = eqpVO2.getApplStts();
			if(action.equals("apply")) {
				if(applStts == null || applStts.equals("")) {
					eqpVO2.setApplId(empVO.getEmpId());
					eqpVO2.setApplStts("대여신청");
					eqpLogVO.setStts(eqpVO2.getApplStts());
				}
				else if(applStts.equals("대여신청")) {
					eqpVO2.setApplStts("대여중");
					eqpLogVO.setStts(applStts + "승인");
				}
				else if(applStts.equals("반납신청")) {
					eqpVO2.setApplStts("");
					eqpVO2.setApplDt("");
					eqpLogVO.setStts(applStts + "승인");
				}
				else if(applStts.equals("분실신청")) {
					eqpVO2.setApplStts("");
					eqpVO2.setApplDt("");
					eqpVO2.setLossStts("Y");
					eqpLogVO.setStts(applStts + "승인");
				}
				
			}
			else if(action.equals("refuse")) {
				if(applStts.equals("대여신청")) {
					eqpVO2.setApplStts("");
					eqpVO2.setApplDt("");
					eqpLogVO.setStts("대여신청반려");
				}
				else if(applStts.equals("반납신청")) {
					eqpVO2.setApplStts("대여중");
					eqpLogVO.setStts("반납신청반려");
				}
				else if(applStts.equals("분실신청")) {
					eqpVO2.setApplStts("대여중");
					eqpLogVO.setStts("분실신청반려");
				}
			}
			else if(action.equals("return")) {
				if(applStts.equals("대여중")) {
					eqpVO2.setApplStts("반납신청");
					eqpLogVO.setStts(eqpVO2.getApplStts());
				}
			}
			else if(action.equals("noreturn")) {
				if(applStts.equals("반납신청")) {
					eqpVO2.setApplStts("대여중");
					eqpLogVO.setStts("반납신청취소");
				}
			}
			else if(action.equals("noapply")) {
				if(applStts.equals("대여신청")) {
					eqpVO2.setApplStts("");
					eqpVO2.setApplDt("");
					eqpLogVO.setStts("대여신청취소");
				}
			}
			else if(action.equals("lost")) {
				if(applStts.equals("대여중")) {
					eqpVO2.setApplStts("분실신청");
					eqpLogVO.setStts(eqpVO2.getApplStts());
				}
			}
			else if(action.equals("nolost")) {
				if(applStts.equals("분실신청")) {
					eqpVO2.setApplStts("대여중");
					eqpLogVO.setStts("분실신청취소");
				}
			}
			applyCount += eqpDAO.applyEqp(eqpVO2);
			
			eqpLogVO.setCrtr(empVO.getEmpId());
			eqpLogVO.setEmpId(eqpVO2.getApplId());
			eqpLogVO.setEqpId(eqpVO2.getEqpId());
			
			eqpLogDAO.createEqpLog(eqpLogVO);
		}
		
		return applyCount > 0;
	}

	@Override
	public List<EqpVO> readEqpByEmpId(EqpVO eqpVO) {
		return eqpDAO.readEqpByEmpId(eqpVO);
	}



	

}
