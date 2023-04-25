<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript">
	$().ready(function(){
		var empId = "${sessionScope.__USER__.empId}";
		<c:if test="${not empty selected}">
			$("li.nav-item.${selected}").addClass("active");
		</c:if>
		$("li.nav-item").children("a").mouseover(function(){
			$(this).closest(".nav").find(".nav-item.active").removeClass("active");
			if($(this).attr("class")!="nav-item sys"){
				$("li.nav-item.sys").removeClass("active");
			}
			$(this).closest("li.nav-item").addClass("active");
		});
		$("div.header").mouseleave(function(){
			$(this).find(".active").removeClass("active");
			<c:if test="${not empty selected}">
				$("li.nav-item.${selected}").addClass("active");
			</c:if>
		});
		$(".sub-item").mouseenter(function(){
			$(this).addClass("active");
		});
		$("#my-info").click(function(){
			var menu = $(this).children(".my-menu");
			if(menu.is(':visible')){
				menu.hide();
			} else{
				menu.show();
			}
		});
		$("#my-info").find(".menu-item.info").click(function(){
			window.open("${context}/emp/detail/"+empId,"회원정보","width=600,height=500");
		});
		$("#my-info").find(".menu-item.chng-pwd").click(function(){
			window.open("${context}/emp/modify/password/"+empId,"비밀번호 변경","width=500,height=500");
		});
	});
</script>
<div class="header bg-black">
	<ul class="nav">
		<li class="nav-item emp">
			<a href="${context}/emp/list">임직원관리</a>
			<ul class="sub-item">
				<li><a href="${context}/emp/create">임직원 등록</a></li>
				<li><a href="${context}/emp/list">임직원 목록</a></li>
				<li><a href="${context}/emp/log/lgn">로그인 이력</a></li>
				<li><a href="${context}/emp/log/acs">화면 접근 이력</a></li>
				<li><a href="${context}/emp/log/pstn">직급 변경 이력</a></li>
				<li><a href="${context}/emp/log/job">직무 변경 이력</a></li>
				<li><a href="${context}/emp/log/dep">부서 변경 이력</a></li>
			</ul>
		</li>
		<li class="nav-item dep">
			<a href="${context}/dep/list">부서관리</a>
			<ul class="sub-item">
				<li><a href="${context}/dep/list">부서 목록</a></li>
				<li><a href="${context}/cmncd/list">부서원 관리</a></li>
				<li><a href="${context}/job/list">직무 관리</a></li>
				<li><a href="${context}/pstn">직급 관리</a></li>
			</ul>
		</li>
		<li class="nav-item eqp">
			<a href="${context}/eqp/list">비품관리</a>
			<ul class="sub-item">
				<li><a href="${context}/eqp/list">비품 관리</a></li>
				<li><a href="${context}/eqp/rent">대여 관리</a></li>
				<li><a href="${context}/eqp/apply">대여 신청</a></li>
				<li><a href="${context}/eqp/lost">분실물 관리</a></li>
				<li><a href="${context}/eqp/log">비품내역 관리</a></li>
			</ul>
		</li>
		<li class="nav-item prj">
			<a href="${context}/prj/list">프로젝트관리</a>
			<ul class="sub-item">
				<li><a href="${context}/prj/list">프로젝트 목록</a></li>
				<li><a href="${context}/issu/list">이슈</a></li>
				<li><a href="${context}/req/list">요구사항</a></li>
				<li><a href="${context}/knw/list">지식관리</a></li>
			</ul>
		</li>
		<li class="nav-item sys">
			<a>시스템관리</a>
			<ul class="sub-item">
				<li><a href="${context}/emp/list?admnYn=Y">관리자 관리</a></li>
				<li><a href="${context}/cmncd/list">공통코드 관리</a></li>
				<li><a href="${context}/pstn/list">직급 관리</a></li>
				<li><a href="${context}/job/list">직무 관리</a></li>
			</ul>
		</li>
		<li class="nav-item msg">
			<a href="${context}/rcvmsg/list">쪽지</a>
			<ul class="sub-item">
				<li><a href="${context}/sndmsg/send">쪽지보내기</a></li>
			</ul>
		</li>
	</ul>
	<div class="inline profile">
		<div id="my-info">
			${sessionScope.__USER__.fNm}
			<div class="my-menu" hidden>
				<div class="menu-item info">회원정보</div>
				<div class="menu-item chng-pwd">비밀번호 변경</div>
			</div>
		</div>
		<a href="${context}/emp/lgt">(Logout)</a>
	</div>
</div>