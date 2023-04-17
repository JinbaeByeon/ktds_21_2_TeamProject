package com.kpms.sndmsg.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.sndmsg.vo.SndMsgVO;

@Repository
public class SndMsgDAOImpl extends SqlSessionDaoSupport implements SndMsgDAO {

	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<SndMsgVO> readAllSndMsgVO(SndMsgVO sndMsgVO) {
		return getSqlSession().selectList("SndMsgVO.readAllSndMsgVO", sndMsgVO);
	}

	@Override
	public int createOneSndMsg(SndMsgVO sndMsgVO) {
		return getSqlSession().insert("SndMsgVO.createOneSndMsg", sndMsgVO);
	}

	@Override
	public int updateOneSndMsg(SndMsgVO sndMsgVO) {
		return getSqlSession().update("SndMsgVO.updateOneSndMsg", sndMsgVO);
	}

	@Override
	public int deleteOneSndMsg(int msgId) {
		return getSqlSession().update("SndMsgVO.deleteOneSndMsg", msgId);
	}

	@Override
	public int deleteSndMsgBySelectedMsgId(List<Integer> msgId) {
		return getSqlSession().update("SndMsgVO.deleteSndMsgBySelectedMsgId", msgId);
	}
}
