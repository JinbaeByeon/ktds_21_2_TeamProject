package com.kpms.prj.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.prj.vo.PrjVO;

@Repository
public class PrjDAOImpl extends SqlSessionDaoSupport implements PrjDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<PrjVO> readAllPrjVO(PrjVO prjVO) {
		return getSqlSession().selectList("Prj.readAllPrjVO", prjVO);
	}
	
	@Override
	public List<PrjVO> readAllPrjVONoPagination(String prjNm) {
		return getSqlSession().selectList("Prj.readAllPrjVONoPagination", prjNm);
	}
	@Override
	public PrjVO readOnePrjVOByPrjId(String prjId) {
		return getSqlSession().selectOne("Prj.readOnePrjVOByPrjId", prjId);
	}
	
	@Override
	public int createOnePrj(PrjVO prjVO) {
		return getSqlSession().insert("Prj.createOnePrj", prjVO);
	}

	@Override
	public int updateOnePrj(PrjVO prjVO) {
		return getSqlSession().update("Prj.updateOnePrj", prjVO);
	}

	@Override
	public int deleteOnePrjByPrjId(String prjId) {
		return getSqlSession().delete("Prj.deleteOnePrjByPrjId", prjId);
	}

	@Override
	public int deletePrjByPrjList(List<String> prjIdList) {
		return getSqlSession().delete("Prj.deletePrjByPrjList", prjIdList);
	}

}
