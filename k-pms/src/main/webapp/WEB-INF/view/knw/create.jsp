<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Random"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp" />
<script type="text/javascript">
	function addGnrFn(data) {

		var gnrItems = $("#addGenreBtn").closest(".create-group")
				.find(".items");

		if (gnrItems.find("." + data.gnrid).length > 0) {
			gnr.alert(data.gnrnm + "은(는) 추가된 장르입니다.");
			return;
		}

		var len = gnrItems.find(".gnr-item").length;
		var itemDiv = $("<div class='gnr-item "+ data.gnrid +"'></div>");

		console.log(gnrItems);
		var itemId = $("<input type='hidden' name='gnrList["+len+"].gnrId' />");
		itemId.val(data.gnrid);
		itemDiv.append(itemId);

		var itemSpan = $("<span></span>");
		itemSpan.text(data.gnrnm);
		itemDiv.append(itemSpan);

		var itemRemoveBtn = $("<button>x</button>");
		itemRemoveBtn.click(function() {

			$(this).closest("." + data.gnrid).remove();

		});

		itemDiv.append(itemRemoveBtn);
		gnrItems.append(itemDiv);

	}
	$().ready(function() {

	});
</script>
</head>
<body>
	<div class="main-layout">
		<jsp:include page="../include/header.jsp" />
		<div>
			<jsp:include page="../include/cmnCdSidemenu.jsp" />
			<jsp:include page="../include/content.jsp" />

			<h1>지식 관리 등록</h1>
			<div>
				<form id="create-form">
					<input type="hidden" name="knwId" value="${knwVO.knwId}" />
					<div class="create-group">
						<label for="ttl">제목</label> <input type="text" id="ttl" name="ttl" />
					</div>
					<div class="create-group">
						<label for="cntnt">내용</label>
						<textarea id="smr" name="cntnt">${knwVO.cntnt}</textarea>
					</div>
				</form>
			</div>

			<div class="align-right">
				<button id="new_btn" class="btn-primary">등록</button>
				<button id="delete_btn" class="btn-delete">삭제</button>
			</div>
			<jsp:include page="../include/footer.jsp" />
		</div>
	</div>
</body>
</html>