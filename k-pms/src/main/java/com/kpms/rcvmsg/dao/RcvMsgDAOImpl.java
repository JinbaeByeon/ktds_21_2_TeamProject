package com.kpms.rcvmsg.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.rcvmsg.vo.RcvMsgVO;

@Repository
public class RcvMsgDAOImpl extends SqlSessionDaoSupport implements RcvMsgDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<RcvMsgVO> readAllRcvMsgVO(RcvMsgVO rcvMsgVO) {
		return getSqlSession().selectList("RcvMsg.readAllRcvMsgVO", rcvMsgVO);
	}

	@Override
	public int createOneRcvMsg(RcvMsgVO rcvMsgVO) {
		return getSqlSession().insert("RcvMsg.createOneRcvMsg", rcvMsgVO);
	}

	@Override
	public int deleteOneRcvMsg(String msgId) {
		return getSqlSession().update("RcvMsg.deleteOneRcvMsg", msgId);
	}


	@Override
	public int deleteRcvMsgBySelectedMsgId(List<Integer> msgId) {
		return getSqlSession().update("RcvMsg.deleteRcvMsgBySelectedMsgId", msgId);
	}
	
}
