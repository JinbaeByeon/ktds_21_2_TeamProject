<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript">
	$().ready(function(){
		function readCnt(){
			$.get("${context}/api/rcvmsg/cnt",function(response){
				var cnt = response.data;
				var msgCnt = $("#msg_cnt");
				if(cnt==0){
					msgCnt.text("");
				} else{
					msgCnt.text(cnt);
				}
			});
		}
		readCnt();
		setInterval(readCnt, 3000);
		
		$("#my-info").children(".my-menu").hide();
		var empId = "${sessionScope.__USER__.empId}";
		<c:if test="${not empty selected}">
			$("li.nav_item.${selected}").addClass("active");
		</c:if>
		$("li.nav_item").mouseover(function(){
			$(this).closest(".nav").find(".nav_item.active").removeClass("active");
			if($(this).attr("class")!="nav_item ${selected}"){
				$("li.nav_item.${selected}").removeClass("active");
			}
			$(this).addClass("active");
			$(this).find(".sub_item").addClass("active");
		});
		$("div.header").mouseleave(function(){
			$(".top_navbar > .menu > .nav_menu > .nav").find(".active").removeClass("active");
			<c:if test="${not empty selected}">
				$("li.nav_item.${selected}").addClass("active");
			</c:if>
		});
		$(".sub_item").mouseenter(function(){
			$(this).addClass("active");
		});

		$("#my-info").click(function(){
			window.open("${context}/emp/detail/"+empId,"회원정보","width=600,height=500");
		});
	});
</script>
<div class="header"></div>
<div id="spinner_panel">
	<div><span>
		<img id="spinner" src='${context}/img/spinner.gif'>
	</span></div>
</div>
<div class="wrapper">
	<div class="top_navbar">
	    <div class="left_blank">
	      <div class="profile">
	        <div class="img">
	           <c:if test="${not empty sessionScope.__USER__.prflPht}">
                   <img src="${context}/emp/prfl/${sessionScope.__USER__.prflPht}/" />
               </c:if>
               <c:if test="${empty sessionScope.__USER__.prflPht}">
                   <img src="${context}/img/base_profile.png" />
               </c:if>
	          <p id="my-info">
	          	  ${sessionScope.__USER__.lNm}${sessionScope.__USER__.fNm}
	          </p>
	        </div>
	      </div>
	    </div>
	    <div class="menu">
	      <div class="nav_menu">
	        <ul class="nav">
	          <li class="nav_item home">
	            <a href="${context}/index">홈</a>
	          </li>
	          <li class="nav_item emp">
	            <a href="${context}/emp/list">임직원관리</a>
	            <ul class="sub_item">
	              <li><a href="${context}/emp/create">임직원 등록</a></li>
	              <li><a href="${context}/emp/list">임직원 목록</a></li>
	              <li><a href="${context}/emp/log/lgn">로그인 이력</a></li>
	              <li><a href="${context}/emp/log/acs">화면 접근 이력</a></li>
	              <li><a href="${context}/emp/log/pstn">직급 변경 이력</a></li>
	              <li><a href="${context}/emp/log/job">직무 변경 이력</a></li>
	              <li><a href="${context}/emp/log/dep">부서 변경 이력</a></li>
	            </ul>
	          </li>
	          <li class="nav_item dep">
	            <a href="${context}/dep/list">부서</a>
	            <ul class="sub_item">
	              <li><a href="${context}/dep/list">부서 상세</a></li>
	              <li><a href="${context}/tm/list">팀 관리</a></li>
	              <li><a href="${context}/dep/mbrlist">팀원 관리</a></li>
	            </ul>
	          </li>
	          <li class="nav_item eqp">
	            <a href="${context}/eqp/list">비품</a>
	            <ul class="sub_item">
	              <li><a href="${context}/eqp/list">비품 관리</a></li>
	              <li><a href="${context}/eqp/rent">대여 관리</a></li>
	              <li><a href="${context}/eqp/apply">대여 신청</a></li>
	              <li><a href="${context}/eqp/lost">분실물 관리</a></li>
	              <li><a href="${context}/eqp/log">비품 변경 이력</a></li>
	            </ul>
	          </li>
	          <li class="nav_item prj">
	            <a href="${context}/prj/list">프로젝트</a>
	            <ul class="sub_item">
	              <li><a href="${context}/prj/list">프로젝트 목록</a></li>
	              <li><a href="${context}/req/list">요구사항</a></li>
	              <li><a href="${context}/issu/list">이슈</a></li>
	              <li><a href="${context}/knw/list/0">지식관리</a></li>
	              <li><a href="${context}/knw/list/1">사내지식관리</a></li>
	              <li><a href="${context}/prj/log">프로젝트 변경 이력</a></li>
	            </ul>
	          </li>
	          <li class="nav_item sys">
	            <a>시스템관리</a>
	            <ul class="sub_item">
	              <li><a href="${context}/cmncd/list">공통코드 관리</a></li>
	              <li><a href="${context}/pstn/list">직급 관리</a></li>
	              <li><a href="${context}/job/list">직무 관리</a></li>
	            </ul>
	          </li>
	          <li class="nav_item msg">
	            <a href="${context}/rcvmsg/list">쪽지 <span id= "msg_cnt"></span></a>
	            <ul class="sub_item">
	              <li><a href="${context}/sndmsg/send">쪽지보내기</a></li>
	            </ul>
	          </li>
	        </ul>
	      </div>
	    </div>
	  </div>
	  <div class="sub_item_background">
	  </div>
