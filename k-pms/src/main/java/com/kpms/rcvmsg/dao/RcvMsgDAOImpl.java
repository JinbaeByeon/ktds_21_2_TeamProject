package com.kpms.rcvmsg.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kpms.rcvmsg.vo.MsgSearchVO;
import com.kpms.rcvmsg.vo.RcvMsgVO;
import com.kpms.sndmsg.vo.SndMsgVO;

@Repository
public class RcvMsgDAOImpl extends SqlSessionDaoSupport implements RcvMsgDAO {
	
	@Autowired
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}

	@Override
	public List<RcvMsgVO> readAllRcvMsgVO(MsgSearchVO rcvMsgVO) {
		return getSqlSession().selectList("RcvMsg.readAllRcvMsgVO", rcvMsgVO);
	}

	@Override
	public SndMsgVO readOneSndMsgVO(String rcvmsgId) {
		return getSqlSession().selectOne("RcvMsg.readOneSndMsgVO", rcvmsgId);
	}
	
	@Override
	public int createOneRcvMsg(RcvMsgVO rcvMsgVO) {
		return getSqlSession().insert("RcvMsg.createOneRcvMsg", rcvMsgVO);
	}
	@Override
	public int createRcvMsg(SndMsgVO sndMsgVO) {
		return getSqlSession().insert("RcvMsg.createRcvMsg", sndMsgVO);
	}
	
	@Override
	public int deleteOneRcvMsg(String msgId) {
		return getSqlSession().update("RcvMsg.deleteOneRcvMsg", msgId);
	}


	@Override
	public int deleteRcvMsgBySelectedMsgId(List<String> msgId) {
		return getSqlSession().update("RcvMsg.deleteRcvMsgBySelectedMsgId", msgId);
	}

	@Override
	public int updateRcvMsgReadByRcvMsgIdList(List<String> rcvMsgIdList) {
		return getSqlSession().update("RcvMsg.updateRcvMsgReadByRcvMsgIdList", rcvMsgIdList);
	}

}
