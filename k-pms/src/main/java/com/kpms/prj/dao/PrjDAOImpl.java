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
		// TODO Auto-generated method stub
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<PrjVO> readAllPrjVO(PrjVO prjVO) {
		return getSqlSession().selectList("Prj.readAllPrjVO", prjVO);
	}

	@Override
	public int createOnePrj(PrjVO prjVO) {
		return getSqlSession().insert("Prj.createOnePrj", prjVO);
	}

}
