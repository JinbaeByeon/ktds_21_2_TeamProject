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
		return getSqlSession().selectList("SndMsg.readAllSndMsgVO", sndMsgVO);
	}

	@Override
	public int createOneSndMsg(SndMsgVO sndMsgVO) {
		return getSqlSession().insert("SndMsg.createOneSndMsg", sndMsgVO);
	}

	@Override
	public int updateOneSndMsg(SndMsgVO sndMsgVO) {
		return getSqlSession().update("SndMsg.updateOneSndMsg", sndMsgVO);
	}

	@Override
	public int deleteOneSndMsg(String msgId) {
		return getSqlSession().update("SndMsg.deleteOneSndMsg", msgId);
	}

	@Override
	public int deleteSndMsgBySelectedMsgId(List<Integer> msgId) {
		return getSqlSession().update("SndMsg.deleteSndMsgBySelectedMsgId", msgId);
	}
}
