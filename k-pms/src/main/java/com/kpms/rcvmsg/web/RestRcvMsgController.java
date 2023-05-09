package com.kpms.rcvmsg.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.kpms.common.api.vo.APIDataResponseVO;
import com.kpms.common.api.vo.APIResponseVO;
import com.kpms.common.api.vo.APIStatus;
import com.kpms.emp.vo.EmpVO;
import com.kpms.rcvmsg.service.RcvMsgService;
import com.kpms.rcvmsg.vo.MsgVOList;

@RestController
public class RestRcvMsgController {

	@Autowired
	private RcvMsgService rcvMsgService;

	@GetMapping("/api/rcvmsg/delete/{msgId}")
	public APIResponseVO doDeleteRcvMsg(@PathVariable String msgId) {
		boolean deleteResult = rcvMsgService.deleteOneRcvMsg(msgId);

		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		} else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	@PostMapping("/api/rcvmsg/delete")
	public APIResponseVO doDeleteRcvMsgBySelectedMsgId(@RequestParam List<String> rcvMsgIdList) {
		boolean deleteResult = rcvMsgService.deleteRcvMsgBySelectedMsgId(rcvMsgIdList);

		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		} else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	@PostMapping("api/msg/delete/trash")
	public APIResponseVO doDeleteTrashMsg(MsgVOList msgVOList) {
		boolean deleteResult = rcvMsgService.deleteTrashMsg(msgVOList);

		if (deleteResult) {
			return new APIResponseVO(APIStatus.OK);
		} else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}

	@PostMapping("/api/rcvmsg/update")
	public APIResponseVO doUpdateRcvMsg(@RequestParam List<String> rcvMsgIdList) {
		boolean updateResult = rcvMsgService.updateRcvMsgReadByRcvMsgIdList(rcvMsgIdList);
		
		if (updateResult) {
			return new APIResponseVO(APIStatus.OK);
		} else {
			return new APIResponseVO(APIStatus.FAIL);
		}
	}
	
	@PostMapping("/api/msg/restore")
	public APIResponseVO doRestoreRcvMsg(MsgVOList msgVOList) {
		boolean restoreResult = rcvMsgService.restoreRcvMsg(msgVOList); {
			
			if (restoreResult) {
				return new APIResponseVO(APIStatus.OK);
			} else {
				return new APIResponseVO(APIStatus.FAIL);
			}
		}
	}
	
	@GetMapping("/api/rcvmsg/cnt")
	public APIDataResponseVO doReadCntUnReadRcvMsg(@SessionAttribute("__USER__") EmpVO user) {
		int cnt = rcvMsgService.readCntUnReadSndMsg(user.getEmpId());
		return new APIDataResponseVO(APIStatus.OK, cnt);
	}
}
