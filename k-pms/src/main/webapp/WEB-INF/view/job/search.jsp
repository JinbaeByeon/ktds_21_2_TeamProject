<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="../include/stylescript.jsp"/>
<script type="text/javascript"> <!-- -->
	$().ready(function() {
		$("#all_check").change(function() {
			$(".check_idx").prop("checked", $(this).prop("checked"));
		});
		
		$(".check_idx").change(function() {
			var count = $(".check_idx").length;
			var checkCount = $(".check_idx:checked").length;
			$("#all_check").prop("checked", count == checkCount);
		});
		
		$("cancel_btn").click(function() {
			window.close();
		});
		
		$("#regist_btn").click(function() {
			var checkbox = $(".check_idx:checked");
			if (checkbox.length == 0) {
				alert("직무를 선택하세요.");
				return;
			}
			
			checkbox.each(function() {
				var each = $(this).closest("tr").data();
				opener.addJobFn(each);
			});
		});
	});

</script>
</head>
<body>
	<div class="search-popup content">
		<h1>직무검색</h1>
		<form>
			<div class="search-group">
				<label for="jobNm">직무명</label>
				<input type="text" id="jobNm" name="jobNm" class="grow-1"/>
			</div>
		</form>
	</div>
</body>
</html>