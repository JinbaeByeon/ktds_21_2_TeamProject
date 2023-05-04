<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$().ready(function(){
		$("#view_cnt").change(function(){
			movePage(0);
		});
	});
</script>
<div class="view_info">
	<div class="view_cnt">
		<select id="view_cnt" name="viewCnt">
			<option value="5" ${viewCnt eq '5' ? 'selected' : ''}>5건</option>
			<option value="10" ${viewCnt eq '10' ? 'selected' : ''}>10건</option>
			<option value="15" ${viewCnt eq '15' ? 'selected' : ''}>15건</option>
			<option value="20" ${viewCnt eq '20' ? 'selected' : ''}>20건</option>
			<option value="30" ${viewCnt eq '30' ? 'selected' : ''}>30건</option>
			<option value="50" ${viewCnt eq '50' ? 'selected' : ''}>50건</option>
		</select>
	</div>
</div>