<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<c:set var="date" value="<%= new Random().nextInt() %>"/>
<c:set scope="request" var="selected" value="emp"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사원 목록</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		var detailWindow;
		var depWindow;
		var jobWindow;
		var pstnWindow;
		var emplmntSttsData;
		$().ready(function(){
			AjaxUtil.disableSpinner();
			$(".sidebar > ul li a").removeClass("active")
			$("#emp_list").addClass("active");
			
			$.get("${context}/api/cmncd/list/001", function(response) {
				var emplmntSttsSelect = $("#emplmntStts-select");
				emplmntSttsData = response.data;
				for (var i in emplmntSttsData) {
					var cdNm = emplmntSttsData[i].cdNm;
					var option = $("<option value='" + emplmntSttsData[i].cdId + "'></option>");
					option.append(cdNm);
					emplmntSttsSelect.append(option)
					if(emplmntSttsData[i].cdId=="${empVO.emplmntStts}"){
						emplmntSttsSelect.val(emplmntSttsData[i].cdId);
					}
				}
			});
			$().find("#emplmntStts-select").val("${empVO.emplmntStts}").prop("selected",true);
			$("#emplmntStts-select").change(function(e){
				movePage(0);
			});
			$("#pwd-reset").click(function(){
				if(!checkIdx()){
					return;
				}
				if(!confirm("해당 사원들의 비밀번호를 초기화하시겠습니까?")){
					return;
				}
				var form = $("<form></form>")
				
				$(".check_idx:checked").each(function() {
					form.append("<input type='hidden' name='empIdList' value='"+ $(this).val() +"'>");
				});
				$.post("${context}/api/emp/reset/password",form.serialize(), function(response) {
					if (response.status == "200 OK") {
						location.reload();
					} else {
						alert(response.message);
					}
				});
			});
			
			$("#pstn-change").click(function(){
				if(!checkIdx()){
					return;
				}
				pstnWindow = window.open("${context}/pstn/search","직급 변경","width=400,height=600");
			});
			$("#job-change").click(function(){
				if(!checkIdx()){
					return;
				}
				jobWindow = window.open("${context}/job/search","직무 변경","width=400,height=600");
			});
			$("#dep-change").click(function(){
				if(!checkIdx()){
					return;
				}
				depWindow = window.open("${context}/dep/search","부서 변경","width=500,height=600");
			});

			$(".search-option").change(function(){
				movePage(0);
			});
			
			$(".list_table tbody > tr > td").not(".check").click(function() {
				var empId = $(this).closest("tr").data("empid");
				if(empId){
					detailWindow = window.open("${context}/emp/detail/"+ empId,"사원 정보","width=600,height=700, top= 100, left = 500");
				}
			});
			
			$("#all_check").change(function(){
				$(".check_idx").prop("checked", $(this).prop("checked"));
			});
			
			function checkIndex(){
				var count = $(".check_idx").length;
				var checkCount = $(".check_idx:checked").length;
				$("#all_check").prop("checked", count == checkCount);
			}
			
			$(".check_idx").change(function(){
				checkIndex();
			});
			$(".check_idx").click(function(e){
				$(this).prop("checked",$(this).prop("checked")==false);
			});
			$(".list_table > tbody > tr > td.check").click(function(){
				var check_idx = $(this).closest("tr").find(".check_idx");
				check_idx.prop("checked",check_idx.prop("checked")==false);
				checkIndex();
			});
			$("#search-btn").click(function(e){
				e.preventDefault();
				movePage(0);
			});
			$("#btn-return").click(function(e){
				chngEmplmntStss("001_01");
			});
			$("#btn-leave").click(function(e){
				chngEmplmntStss("001_02");
			});
			$("#btn-exResign").click(function(e){
				chngEmplmntStss("001_03");
			});
			$("#btn-resign").click(function(e){
				chngEmplmntStss("001_04");
			});
			function chngEmplmntStss(val){
				var form = $("<form></form>");
				
				$(".check_idx:checked").each(function() {
					form.append("<input type='hidden' name='empIdList' value='"+ $(this).val() +"'>");
				});
				form.append("<input type='hidden' name='emplmntStts' value='"+val+"'>");
				$.post("${context}/api/emp/update/emplmntStts",form.serialize(), function(response) {
					if (response.status == "200 OK") {
						location.reload();
					} else {
						alert(response.errorCode + "/" + response.message);
					}
				});
			}
			$("#export_excel").click(function(){
				location.href = "${context}/emp/export/excel"; 
			});

			function checkIdx(){
				var check = $(".check_idx:checked");
				if(check.length == 0){
					alert("선택된 사원이 없습니다.");
					return false;
				}
				return true;
			}
		});
		function movePage(pageNo) {
			var empId = $("#empId").val();
			var fNm = $("#fNm").val();
			var searchType = $(".search-option").val();
			var emplmntStts = $("#emplmntStts-select").val();
			var qryStr = "searchType=" + searchType;
			qryStr +=  "&pageNo=" + pageNo;
			if(emplmntStts != "default"){
				qryStr += "&emplmntStts="+emplmntStts;
			}
			if(empId != null && empId != ''){
				qryStr += "&empId="+empId;
			}
			if(fNm != null && fNm != ''){
				qryStr += "&fNm="+fNm;
			}
			var viewCnt = $("#view_cnt").val();
			qryStr += "&viewCnt=" + viewCnt;

			location.href = "${context}/emp/list?"  + qryStr;
		}
		function addPstnFn(pstnData){
			pstnData.name='pstnId';
			pstnData.id = pstnData.pstnid;
			pstnData.url = '/api/emp/update/pstn';
			pstnData.rsn = pstnWindow.prompt("변경사유를 입력하세요.");
			pstnData.window = pstnWindow;
			if(!postCheckIdx(pstnData)){
				return;
			}
			pstnWindow.close();
		}
		
		function addJobFn(jobData){
			jobData.name='jobId';
			jobData.id = jobData.jobid;
			jobData.url = '/api/emp/update/job';
			jobData.rsn = jobWindow.prompt("변경사유를 입력하세요.");
			jobData.window = jobWindow;
			if(!postCheckIdx(jobData)){
				return;
			}
			jobWindow.close();
		}
		
		function addDepFn(depData){
			depData.name='depId';
			depData.id = depData.depid;
			depData.url = '/api/emp/update/dep';
			depData.rsn = depWindow.prompt("변경사유를 입력하세요.");
			depData.window = depWindow;
			if(!postCheckIdx(depData)){
				return;
			};
			depWindow.close();
		}
		function postCheckIdx(data){
			console.log(data.rsn);
			var form = $("<form></form>")
			
			$(".check_idx:checked").each(function() {
				form.append("<input type='hidden' name='empIdList' value='"+ $(this).val() +"'>");
			});
			if(data != null){
				form.append("<input type='hidden' name='"+data.name+"' value='"+ data.id +"'>");
				if(data.rsn == null){
					return false;
				}
				if(data.rsn == '') {
					data.window.alert("변경사유를 입력하지 않았습니다.");
					return false;
				}
				form.append("<input type='hidden' name='chngRsn' value='"+ data.rsn +"'>");
			}
			$.post("${context}"+data.url,form.serialize(), function(response) {
				if (response.status == "200 OK") {
					location.reload();
				} else {
					alert(response.errorCode + "/" + response.message);
				}
			});
			return true;
		}
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/empSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
			<div class="path">임직원 관리 > 임직원 목록</div>
		      <div class="search_wrapper">
		      <form>
		        <div class="search_box">
					<select class="search-option" name="searchType">
						<option ${searchType== "ID" ? "selected" : ""}>ID</option>
						<option ${searchType== "이름" ? "selected" : ""}>이름</option>
					</select>
		          <div class="search_field">
		          	<c:if test="${searchType== 'ID'}">
						<input type="text" id="empId" name="empId" class="input" value="${empVO.empId}" placeholder="Search"/>
					</c:if>
					<c:if test="${searchType== '이름'}">
						<input type="text" id="fNm" name="fNm" class="input" value="${empVO.fNm}" placeholder="Search" />
					</c:if>
		          </div>
		          <div class="search-icon">
		          	<button class="btn-search" id="search-btn"><span class="material-symbols-outlined">search</span></button>
		          </div>
		        </div>
		        </form>
		      </div>
		      <div class="list_section">
				<jsp:include page="../include/viewCnt.jsp" />
			    <div class="total">총 ${empList.size() > 0 ? empList.get(0).totalCount : 0}건</div>
			    <img id = "export_excel" src="${context}/img/excel-export.png" />
		        <table class="list_table">
		          <thead>
						<tr>
							<th style="width: 5%; text-align:center;"><input type="checkbox" id="all_check"/></th>
							<th style="width: 8%;">ID</th>
							<th style="width: 9%;">이름</th>
							<th style="width: 10%;">생성일</th>
							<th>
								<select id="emplmntStts-select">
									<option value="default">재직상태</option>
								</select>
							</th>
							<th style="width: 8%;">관리자여부</th>
							<th style="width: 7%;">직급</th>
							<th style="width: 7%;">직무</th>
							<th style="width: 7%;">부서</th>
							<th style="width: 9%;">최근로그인IP</th>
							<th style="width: 10%;">최근로그인날짜</th>
							<th style="width: 11%;">최근로그인실패날짜</th>
							<th style="width: 10%;">로그인실패횟수</th>
						</tr>
		          </thead>
		          <tbody>
						<c:choose>
							<c:when test="${not empty empList}">
								<c:forEach items="${empList}"
										   var="emp"
										   varStatus="index">
									<tr data-empid="${emp.empId}" 
									    data-fnm="${emp.fNm}"
									    data-lnm="${emp.lNm}"
									    data-crtdt="${emp.crtDt}"
									    data-emplmntstts="${emp.emplmntStts}"
									    data-admnyn="${emp.admnYn}"
									    data-pstnid="${emp.pstnId}"
									    data-jobid="${emp.jobId}"
									    data-depid="${emp.depId}"
									    data-lgncnt="${emp.lgnCnt}">
										<td class="check" style="text-align:center;">
											<input type="checkbox" class="check_idx" value="${emp.empId}">
										</td>
										<td>${emp.empId}</td>
										<td>${emp.lNm}${emp.fNm}</td>
										<td>${emp.crtDt}</td>
										<td>${emp.emplmntSttsVO.cdNm}</td>
										<td>
											<c:if test="${emp.admnYn=='Y'}">
												<span>관리자</span>
											</c:if>
											<c:if test="${emp.admnYn=='N'}">
												<span>일반회원</span>
											</c:if>
										</td>
										<td>${emp.pstn.pstnNm}</td>
										<td>${emp.job.jobNm}</td>
										<td>${emp.dep.depNm}</td>
										<td>${emp.ltstLgnIp}</td>
										<td>${emp.ltstLgnDt}</td>
										<td>${emp.failDt}</td>
										<td>${emp.lgnCnt}</td>
										
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="11" class="no-items">
									등록된 사원이 없습니다.
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
		          </tbody>
		        </table>
					<c:import url="../include/pagenate.jsp">
	                  <c:param name="pageNo" value="${pageNo}"/>
	                  <c:param name="pageCnt" value="${pageCnt}"/>
	                  <c:param name="lastPage" value="${lastPage}"/>
	                  <c:param name="path" value="${context}/prj"/>
	               </c:import>
		      </div>
		      	<div class="buttons">
					<button id="pwd-reset" class="btn pwd reset">비밀번호 초기화</button>
					<button id="pstn-change" class="btn pstn change">직급 변경</button>
					<button id="job-change" class="btn job change">직무 변경</button>
					<button id="dep-change" class="btn dep change">부서 변경</button>
				</div>
		        <div class="buttons">
		          	<c:if test="${empVO.emplmntStts== '001_01'}">
						<button id="btn-exResign" class="btn applStts">퇴사예정</button>
					</c:if>
					<c:if test="${empVO.emplmntStts== '001_03'}">
						<button id="btn-resign" class="btn applStts">퇴사</button>
					</c:if>
					<c:if test="${empVO.emplmntStts== '001_01'}">
						<button id="btn-leave" class="btn applStts2">휴직</button>
					</c:if>
					<c:if test="${empVO.emplmntStts== '001_02'}">
						<button id="btn-return" class="btn applStts3">복직</button>
					</c:if>
		        </div>
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>