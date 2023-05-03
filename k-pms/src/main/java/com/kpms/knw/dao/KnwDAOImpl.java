package com.kpms.knw.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.kpms.knw.vo.KnwSearchVO;
import com.kpms.knw.vo.KnwVO;

@Repository
public class KnwDAOImpl extends SqlSessionDaoSupport implements KnwDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
	
	@Override
	public int createOneKnw(KnwVO knwVO) {
		return getSqlSession().insert("Knw.createOneKnw", knwVO);
	}
	
	@Override
	public int createOneCommonKnw(KnwVO knwVO) {
		return getSqlSession().insert("Knw.createOneCommonKnw", knwVO);
	}

	@Override
	public List<KnwVO> readAllKnw(KnwSearchVO knwSearchVO) {
		return getSqlSession().selectList("Knw.readAllKnw", knwSearchVO);
	}
	
	@Override
	public KnwVO readOneKnwByKnwId(String KnwId) {
		return getSqlSession().selectOne("Knw.readOneKnwByKnwId", KnwId);
	}

	@Override
	public int updateOneKnw(KnwVO knwVO) {
		return getSqlSession().update("Knw.updateOneKnw", knwVO);
	}

	@Override
	public int deleteOneKnw(String knwId) {
		return getSqlSession().update("Knw.deleteOneKnw", knwId);
	}

	@Override
	public int deleteKnwBySelectedKnwId(List<String> knwIdList) {
		return getSqlSession().update("Knw.deleteKnwBySelectedKnwId", knwIdList);
	}
	
	@Override
	public int deleteKnwByPrjId(String prjId) {
		return getSqlSession().update("Knw.deleteKnwByPrjId", prjId);
	}
	
}
