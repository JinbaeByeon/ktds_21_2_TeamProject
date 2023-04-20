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
	<title>홈페이지</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		var detailWindow;
		
		$().ready(function(){
			$("#pwd-reset").click(function(){
				
				$.get("${context}/api/emp/reset/password/"+,function(){
					
				});
			});
			
			$("#pstn-change").click(function(){
				
			});
			$("#job-change").click(function(){
				
			});
			$("#dep-change").click(function(){
				
			});

			$(".search-option").change(function(){
				movePage(0);
			});
			
			$(".grid > table > tbody > tr > td").not(".check").click(function() {
				var empId = $(this).closest("tr").data("empid");
				detailWindow = window.open("${context}/emp/detail/"+ empId,"사원 정보","width=600,height=500");
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
			$(".grid > table > tbody > tr > td.check").click(function(){
				console.log("!!!");
				var check_idx = $(this).closest("tr").find(".check_idx");
				check_idx.prop("checked",check_idx.prop("checked")==false);
				checkIndex();
			});
			
		});
		function movePage(pageNo) {
			var empId = $("#empId").val();
			var fNm = $("#fNm").val();
			var searchType = $(".search-option").val();
			var qryStr = "searchType=" + searchType;
			qryStr +=  "&pageNo=" + pageNo;
			if(fNm=="undefined"){
				qryStr +=  "&fNm=" + fNm;
			} else if(empId=="undefined"){
				qryStr +=  "&empId=" + empId;
			}
			
			location.href = "${context}/emp/list?"  + qryStr;
		}
	</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp"/>
		<div>
			<jsp:include page="../include/empSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
			<div class="path"> 사원 관리 > 사원 조회</div>
			<form>
				<div class="search-group">
					<select class="search-option" name="searchType">
						<option ${searchType== "ID" ? "selected" : ""}>ID</option>
						<option ${searchType== "이름" ? "selected" : ""}>이름</option>
					</select>
					<c:if test="${searchType== 'ID'}">
						<input type="text" id="empId" name="empId" class="grow-1 mr-10" value="${empVO.empId}"/>
					</c:if>
					<c:if test="${searchType== '이름'}">
						<input type="text" id="fNm" name="fNm" class="grow-1 mr-10" value="${empVO.fNm}"/>
					</c:if>
					<button class="btn-search" id="search-btn">검색</button>
				</div>
			</form>
			<div class="grid">
				<div class="grid-count">
					<div class="align-left left">
						<button id="pwd-reset">비밀번호 초기화</button>
						<button id="pstn-change">직급 변경</button>
						<button id="job-change">직무 변경</button>
						<button id="dep-change">부서 변경</button>
					</div>
					<div class="align-right right">
						총 ${empList.size() > 0 ? empList.get(0).totalCount : 0}건
					</div>
				</div>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all_check"/></th>
							<th>ID</th>
							<th>이름</th>
							<th>생성일</th>
							<th>재직상태</th>
							<th>관리자여부</th>
							<th>직급</th>
							<th>직무</th>
							<th>부서</th>
							<th>최근로그인IP</th>
							<th>최근로그인날짜</th>
							<th>최근로그인실패날짜</th>
							<th>로그인실패횟수</th>
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
										<td class="check">
											<input type="checkbox" class="check_idx" value="${emp.empId}">
										</td>
										<td>${emp.empId}</td>
										<td>${emp.fNm} ${emp.lNm}</td>
										<td>${emp.crtDt}</td>
										<td>${emp.emplmntStts}</td>
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
               	</c:import>
			</div>
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
</body>
</html>