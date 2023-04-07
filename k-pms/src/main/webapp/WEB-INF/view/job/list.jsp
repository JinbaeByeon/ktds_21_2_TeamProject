<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp: include page="../include/styelscript.jsp"/>
<script type="text/javascript">
	$().ready(function() {
		
		$(".grid > table > tbody > tr").click(function() {
			$("#isModify").val("true");
			var data = $(this).data();
			$("#jobId").val(data.jobid);
			$("#crtDt").val(data.crtdt);
			$("#crtr").val(data.crtr);
			$("#mdfyDt").val(data.mdfydt);
			$("#mdfyr").val(data.mdfyr);
			$("#delYn").val(data.delyn);
			$("#jobNm").val(data.jobnm);
			
			$("#useYn").prop("checked", data.useyn== "Y");
		});
		
		$("#new_btn").click(function() {
			$("#isModify").val("false");
			
			$("#jobId").val("");
			$("#crtDt").val("");
			$("#crtr").val("");
			$("#mdfyDt").val("");
			$("#mdfyr").val("");
			$("#delYn").val("");
			$("#jobNm").val("");

			$("useYn").prop("checked", false);
		});
		
		$("#delete_btn").click(function () {
			var jobId = $("#jobId").val();
			if(jobId == "") {
				alert("선택된 직무가 없습니다.");
				return;
			}
			
			if (!confirm("정말 삭제하시겠습니까?")) {
				return;
			}
			$.get("${context}/api/job/delete/" + jobId, function(response) {
				if(response.status == "200 OK") {
					location.reload
				}
			})
		})
	})

</script>
</head>
<body>

</body>
</html>