<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="context" value="${pageContext.request.contextPath}" />
<c:set var="date" value="<%= new Random().nextInt() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서 상세조회</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	$().ready(function() {
		
	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/depSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />
				<div class="path">부서관리 > 부서 상세조회</div>
					<div>	
						<div>
							부서명: ${depVO.depNm}
						</div>
						<div>
							부서ID: ${depVO.depId}
						</div>
						<div>
							부서장ID: ${depVO.depHdId}
						</div>
						<div>
							부서 생성일: ${depVO.depCrtDt}
						</div>
					</div>
					<div>
					리스트로 만들자
						<div>
							팀명: ${tmVO.tmNm}
						</div>
						<div>
							팀ID: ${tmVO.tmId}
						</div>
						<div>
							팀명: ${tmVO.tmNm}
						</div>
						<div>
							팀장ID: ${tmVO.tmHdId}
						</div>
						<div>
							팀생성일: ${tmVO.tmCrtDt}
						</div>
					</div>
						
					
					
		</div>
	</div>
</body>
</html>