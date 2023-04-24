<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />
<c:set scope="request" var="selected" value="prj"/>
<c:set var="admnYn" value="${sessionScope.__USER__.admnYn}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function(){
		
		var data2 = "${reqOneVO.reqId}";
		console.log(data2);
		$("#isModify").val("true");	
		$("#reqId").val("${reqOneVO.reqId}");
		$("#dtlReq").val("${reqOneVO.dtlReq}");
		$("#crtr").val("${reqOneVO.crtr}");
		$("#crtDt").val("${reqOneVO.crtDt}");
		$("#mdfyr").val("${reqOneVO.mdfyr}");
		$("#mdfyDt").val("${reqOneVO.mdfyDt}");
		$("#strtDt").val("${reqOneVO.strtDt}");
		$("#expctEndDt").val("${reqOneVO.expctEndDt}");
		$("#attch").val("${reqOneVO.attch}");
		$("#prjId").val("${reqOneVO.prjId}");
		$("#mnDvlpr").val("${reqOneVO.mnDvlpr}");
		$("#tstRslt").val("${reqOneVO.tstRslt}");
		$("#tskStts").val("${reqOneVO.tskStts}");
		$("#prcsStts").val("${reqOneVO.prcsStts}");
		$("#prrty").val("${reqOneVO.prrty}");
		$("#reqTtl").val("${reqOneVO.reqTtl}");
		$("#reqCnfrNm").val("${reqOneVO.reqCnfrNm}");
		
		$("#useYn").prop("checked", "${reqOneVO.useYn}" == "Y");
			
		
		$("#new_btn").click(function(){
			$("#isModify").val("false"); //등록모드
			
			$("#reqId").val("");
			$("#dtlReq").val("");
			$("#crtr").val("");
			$("#crtDt").val("");
			$("#mdfyr").val("");
			$("#mdfyDt").val("");
			$("#strtDt").val("");
			$("#expctEndDt").val("");
			$("#attch").val("");
			$("#prjId").val("");
			$("#mnDvlpr").val("");
			$("#tstRslt").val("");
			$("#tskStts").val("");
			$("#prcsStts").val("");
			$("#prrty").val("");
			$("#reqTtl").val("");
			
			
			$("#useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function(){
			var reqId = $("#reqId").val();
			if(reqId == ""){
				alert("선택된 요구사항이 없습니다.");
				return;
			}
			
			if(!confirm("정말 삭제하시겠습니까?")){
				return;
			}
			
			$.get("${context}/api/req/delete/" + reqId, function(response){
				if(response.status == "200 OK"){
					location.reload(); //새로고침
				}
				else{
					alert(response.errorCode + "/" + response.message);
				}
			})
		});
					
		$("#save_btn").click(function(){
			var ajaxUtil = new AjaxUtil();
			ajaxUtil.upload("#detail_form","${context}/api/req/update",function(response){
				if(response.status == "200 OK"){
					alert("저장되었습니다.");
					location.href = "${context}/req/list";
				}	
				else{
					alert(response.errorCode + "/" + response.message);
				}
			});
		});
		
		$("#back-btn").click(function(){
			location.href = "${context}/req/list";
		});
		
		$("#prj_search").click(function(event){
			event.preventDefault();
			window.open("${context}/prj/search",
					"프로젝트 검색", "width=500, height=500");
		});

		$("#prjtmmbr_search").click(function(event){
			event.preventDefault();
			window.open("${context}/prjtmmbr/search?prjId=" + $("#prjId").val(),
					"프로젝트팀원 검색", "width=500, height=500");
		});
		
	});

	function addPrjFn(data) {
		
		$("#prjId").val(data.prjid);
		
	}

	function addPrjTmMbrFn(data) {
		
		$("#mnDvlpr").val(data.empid);
		
	}
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/reqSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp" />
				<div class="path"> 상세 정보</div>
				<div class="grid-detail">
					<form id="detail_form" >
						<!-- isModify == true => 수정(update) -->
						<!-- isModify == false => 등록(insert) -->
						<input type="hidden" id="isModify" value="false" />
						<div class="input-group inline">
							<label for="reqId" style="width: 180px;">요구사항 ID</label>
							<input type="text" id="reqId"  name="reqId" value="" readonly />
						</div>
						<div class="input-group inline">
							<label for="reqTtl" style="width: 180px;">제목</label>
							<input type="text" id="reqTtl"  name="reqTtl" value=""/>
						</div>
						<div class="input-group inline">
							<label for="prrty" style="width: 180px;">우선순위</label>
							<select id="prrty"  name="prrty" >
								<option>선택</option>
								<option>1</option>
								<option>2</option>
								<option>3</option>
							</select>
						</div>
						<div class="input-group inline">
							<label for="strtDt" style="width: 180px;">시작일</label>
							<input type="date" id="strtDt"  name="strtDt" value=""/>
						</div>
						<div class="input-group inline">
							<label for="expctEndDt" style="width: 180px;">종료예정일</label>
							<input type="date" id="expctEndDt"  name="expctEndDt" value=""/>
						</div>
						<div class="input-group inline">
							<label for="prjId" style="width: 180px;">프로젝트ID</label>
							<input type="text" id="prjId"  name="prjId" value=""/>
							<button id="prj_search">검색</button>
						</div>
						<div class="input-group inline">
							<label for="prjId" style="width: 180px;">담당개발자</label>
							<input type="text" id="mnDvlpr"  name="mnDvlpr" value=""/>
							<button id="prjtmmbr_search">검색</button>
						</div>
						<div class="input-group inline">
							<label for="reqCnfrNm" style="width: 180px;">확인자</label>
							<input type="text" id="reqCnfrNm"  name="reqCnfrNm" value=""/>
						</div>
						<div class="input-group inline">
							<label for="prcsStts" style="width: 180px;">진행상태</label>
							<select id="prcsStts"  name="prcsStts" >
								<option value="004">선택</option>
								<option value="004_01">접수</option>
								<option value="004_02">분석</option>
								<option value="004_03">처리중</option>
								<option value="004_04">처리완료</option>
							</select>
						</div>
						<div class="input-group inline">
							<label for="tskStts" style="width: 180px;">일정상태</label>
							<select id="tskStts"  name="tskStts" >
								<option value="003">선택</option>
								<option value="003_01">대기중</option>
								<option value="003_02">진행중</option>
								<option value="003_03">연기 필요</option>
							</select>
						</div>
						<div class="input-group inline">
							<label for="tstRslt" style="width: 180px;">테스트 결과</label>
							<select id="tstRslt"  name="tstRslt" >
								<option value="22">선택</option>
								<option value="222">합격</option>
								<option value="2222">불합격</option>
								<option value="22222">보류</option>
							</select>
						</div>
						<div class="input-group inline">
							<label for="lossStts" style="width: 180px;">사용여부</label>
							<input type="checkbox" id="useYn"  name="useYn" value="Y"/>
						</div>
						<div class="input-group inline">
							<label for="dtlReq" style="width: 180px;">내용</label>
							<textarea id="dtlReq" name="dtlReq" >${req.dtlReq}</textarea>
						</div>
					</form>		
				</div>
				<div class="align-right">
					<button id="save_btn" class="btn-primary">저장</button>
					<button id="back-btn" class="btn-delete">뒤로</button>
				</div>		
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>