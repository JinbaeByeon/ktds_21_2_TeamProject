<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="context" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사원 상세페이지</title>
	<jsp:include page="../include/stylescript.jsp"/>
	<script type="text/javascript">
		var gnrWindow;
		var pplWindow;
		$().ready(function(){
			$("#btn-add-gnr").click(function(e){
				e.preventDefault();
				gnrWindow = window.open("${context}/gnr/search","장르검색", "width=500,height=500");
			})
			$(".btn-add.mvppl").click(function(e){
				e.preventDefault();
				pplWindow = window.open("${context}/mvppl/search","영화인검색", "width=500,height=500, location=no");
				var that = this;
				pplWindow.onload = function(){
					pplWindow.targetId=$(that).attr("id");
				}
			})
			$("#save_btn").click(function(){
				var ajaxUtil = new AjaxUtil();
				ajaxUtil.upload("#create-form","${context}/api/mv/update",function(response){
					if(response.status == "200 OK"){
						location.href = "${context}" + response.redirectURL;
					} else if(response.errorCode == "500"){
						alert(response.message);
					} else{
						alert("영화 등록에 실패했습니다.");
					}
				},{"pstr":"uploadFile"});
			});
			$(".btn-remove-item").click(function(e){
				e.preventDefault();
				var id =$(this).data("id");
				var parent = $(this).closest("."+id);
				parent.children("span").css("backgroundColor","#f009");
				
				var idx = $(this).data("idx");
				var type = $(this).data("type");
				if(type=="gnr"){
					var list = "gnrList";
				} else if(type=="mvppl"){
					list = "mvpplList";
					parent.children("input[type=text]").attr("disabled","disabled");
				}
				parent.find("input.status").val("deleted");
				
				$(this).remove();
			});
			$(".rspnsbltRolNm").keyup(function(){
				var orgnRolNm = $(this).data("orgn-rolnm");
				var curRolNm = $(this).val();
				
				var parent = $(this).closest(".mvppl-item");
				var idx = $(this).data("idx");
				var status = parent.find("input.status");
				if(orgnRolNm == curRolNm){
					status.val("");
				} else if(status.val() != "modified"){
					status.val('modified');
				}
			})
		});
		function remove(id){
			$(this).closest("."+id).remove();
		}
		
		function addGnrFn(gnrData) {
			var gnrItems= $("#btn-add-gnr").closest("div").children(".items");
			if(gnrItems.find("." +gnrData.gnrid).length > 0){
				gnrWindow.alert("이미 추가된 장르: " + gnrData.gnrnm);
				return;
			}
			var len = gnrItems.find(".gnr-item").length;
			var itemDiv = $("<div class='gnr-item "+gnrData.gnrid+"'></div>");
			gnrItems.append(itemDiv);
			
			var itemId = $("<input type='hidden' name='gnrList["+len+"].gnrId'/>");
			itemId.val(gnrData.gnrid);
			itemDiv.append(itemId);
			
			var status = $("<input type='hidden' name='gnrList["+len+"].status'/>");
			status.val("added");
			itemDiv.append(status);
			
			var itemSpan = $("<span></span>");
			itemSpan.text(gnrData.gnrnm);
			itemDiv.append(itemSpan);
			
			var itemRemoveBtn = $("<button>X</button>");
			itemRemoveBtn.click(function(){
				$(this).closest("."+gnrData.gnrid).remove();
			});
			itemDiv.append(itemRemoveBtn);
		}
		
		function addPplFn(mvPplData){
			var pplItems= $("#" + mvPplData.id).closest("div").children(".items");
			if(pplItems.find("." +mvPplData.mvpplid).length > 0){
				pplWindow.alert("이미 추가된 영화인: " + mvPplData.nm);
				return;
			}
	
			var len = $("#create-form").find(".mvppl-item").length;
			var itemDiv = $("<div class='mvppl-item "+mvPplData.mvpplid+"'></div>");
			pplItems.append(itemDiv);

			var status = $("<input type='hidden' name='pplList["+len+"].status'/>");
			status.val("added");
			itemDiv.append(status);
			
			var itemId = $("<input type='hidden' name='pplList["+len+"].mvPplId'/>");
			itemId.val(mvPplData.mvpplid);
			itemDiv.append(itemId);
			
			var rolTpId;
			if(mvPplData.id == "btn-add-director"){
				rolTpId="DRCTR";
			} else if(mvPplData.id == "btn-add-scriptor"){
				rolTpId="SCRPTR";
			} else if(mvPplData.id == "btn-add-producer"){
				rolTpId="PRDCR";
			} else if(mvPplData.id == "btn-add-mainActor"){
				rolTpId="MNACTR";
			} else if(mvPplData.id == "btn-add-supportingActor"){
				rolTpId="SPRTACTR";
			} else if(mvPplData.id == "btn-add-extra"){
				rolTpId="EXTR";
			}
			
			var rolTp = $("<input type='hidden' name='pplList["+len+"].rolTp' placeholder='역할 종류'/>");
			rolTp.val(rolTpId);
			itemDiv.append(rolTp);
	
			var itemSpan = $("<span></span>");
			itemSpan.text(mvPplData.nm);
			itemDiv.append(itemSpan);
			
			if(rolTpId == "MNACTR" ||
			   rolTpId == "SPRTACTR" ||
			   rolTpId == "EXTR"){
				var rspnsbltRolNm = $("<input type='text' name='pplList["+len+"].rspnsbltRolNm' placeholder='역할명'/>");
				rspnsbltRolNm.val("");
				itemDiv.append(rspnsbltRolNm);
			}
			
			var itemRemoveBtn = $("<button>X</button>");
			itemRemoveBtn.click(function(){
				$(this).closest("."+mvPplData.mvpplid).remove();
			});
			itemDiv.append(itemRemoveBtn);
		}
	
	</script>
</head>
<body>
	<div class="main-layout">
		<c:import url="../include/header.jsp">
			<c:param name="username" value="${user.mbrNm}"></c:param>
		</c:import>
		<div>
			<jsp:include page="../include/empSidemenu.jsp"/>
			<jsp:include page="../include/content.jsp"/>
				<div class="path"> 
					영화관리 > 
					<a href="${context}/mv/list">영화</a> >
					상세페이지
				</div>
				<div>
					<form id="create-form" enctype="multipart/form-data">
						<input type="hidden" name="mvId" value="${mvVO.mvId}"/>
						<div class="create-group">
							<label for="pstr">포스터</label>
							<img class="profile" src=""/>
							<input type="file" id="pstr" name="pstr"/>
						</div>
						<div class="create-group">
							<label for="mvTtl">영화제목</label>
							<input type="text" id="mvTtl" name="mvTtl" value= "${mvVO.mvTtl}"/>
						</div>
						<div class="create-group">
							<label for="engTtl">영화영어제목</label>
							<input type="text" id="engTtl" name="engTtl" value= "${mvVO.engTtl}"/>
						</div>
						<div class="create-group">
							<label for="scrnStt">상영상태</label>
							<select id="scrnStt" name="scrnStt">
								<option>선택</option>
								<option value="상영중" ${mvVO.scrnStt == '상영중' ? 'selected' : ''}>상영중</option>
								<option value="개봉예정" ${mvVO.scrnStt == '개봉예정' ? 'selected' : ''}>개봉예정</option>
								<option value="상영종료" ${mvVO.scrnStt == '상영종료' ? 'selected' : ''}>상영종료</option>
							</select>
						</div>
						<div class="create-group">
							<label for="scrnTm">상영시간(분)</label>
							<input type="number" id="scrnTm" name="scrnTm" value="${mvVO.scrnTm}"/>
						</div>
						<div class="create-group">
							<label for="opngDt">개봉일</label>
							<input type="date" id="opngDt" name="opngDt" value="${mvVO.opngDt}"/>
						</div>
						<div class="create-group">
							<label for="wtcGrd">상영상태</label>
							<select id="wtcGrd" name="wtcGrd">
								<option>선택</option>
								<option value="전체관람가" ${mvVO.wtcGrd == '전체관람가' ? 'selected' : ''}>전체관람가</option>
								<option value="12세이상관람가" ${mvVO.wtcGrd == '12세이상관람가' ? 'selected' : ''}>12세이상관람가</option>
								<option value="15세이상관람가" ${mvVO.wtcGrd == '15세이상관람가' ? 'selected' : ''}>15세이상관람가</option>
								<option value="청소년관람불가" ${mvVO.wtcGrd == '청소년관람불가' ? 'selected' : ''}>청소년관람불가</option>
							</select>
						</div>
						<div class="create-group">
							<label for="smr">줄거리</label>
							<textarea id="smr" name="smr">${mvVO.smr}</textarea>
						</div>
						<div class="create-group">
							<label for="useYn">게시여부</label>
							<input type="checkbox" id="useYn" name="useYn" value= "Y" ${mvVO.useYn == 'Y' ? 'checked' : ''}/>
						</div>
						<div class="create-group">
							<label for="btn-add-gnr">장르</label>
							<div>
								<div class="items">
									<c:forEach items="${mvVO.gnrList}" var="mvGnr" varStatus="idx">
										<div class='gnr-item ${mvGnr.gnrId}'>
											<input type='hidden' name='gnrList[${idx.index}].gnrId' value="${mvGnr.gnrId}"/>
											<input type='hidden' name='gnrList[${idx.index}].status' class='status'/>
											<span>${mvGnr.gnr.gnrNm}</span>
											<button class="btn-remove-item"
													data-id="${mvGnr.gnrId}"
													data-idx="${idx.index}"
													data-type="gnr">X</button>
										</div>
									</c:forEach>
								</div>
								<button id="btn-add-gnr" class="btn-add">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="btn-add-director">감독</label>
							<div>
								<div class="items">
									<c:set scope="request" var="pplList" value="${mvVO.pplList}" />
									<c:import url="./loadPplList.jsp">
										<c:param name="rolTp" value="DRCTR"></c:param>
									</c:import>
								</div>
								<button id="btn-add-director" class="btn-add mvppl">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="btn-add-scriptor">각본</label>
							<div>
								<div class="items">
									<c:import url="./loadPplList.jsp">
										<c:param name="rolTp" value="SCRPTR"></c:param>
									</c:import>
								</div>
								<button id="btn-add-scriptor" class="btn-add mvppl">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="btn-add-producer">연출</label>
							<div>
								<div class="items">
									<c:import url="./loadPplList.jsp">
										<c:param name="rolTp" value="PRDCR"></c:param>
									</c:import>
								</div>
								<button id="btn-add-producer" class="btn-add mvppl">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="">주연</label>
							<div>
								<div class="items">
									<c:import url="./loadPplList.jsp">
										<c:param name="rolTp" value="MNACTR"></c:param>
									</c:import>
								</div>
								<button id="btn-add-mainActor" class="btn-add mvppl">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="btn-add-supportingActor">조연</label>
							<div>
								<div class="items">
									<c:import url="./loadPplList.jsp">
										<c:param name="rolTp" value="SPRTACTR"></c:param>
									</c:import>
								</div>
								<button id="btn-add-supportingActor" class="btn-add mvppl">+</button>
							</div>
						</div>
						<div class="create-group">
							<label for="btn-add-extra">기타</label>
							<div>
								<div class="items">
									<c:import url="./loadPplList.jsp">
										<c:param name="rolTp" value="EXTR"></c:param>
									</c:import>
								</div>
								<button id="btn-add-extra" class="btn-add mvppl">+</button>
							</div>
						</div>
					</form>
				</div>
				<div class="align-right">
					<button id="save_btn" class="btn-primary">저장</button>
					<button id="delete_btn" class="btn-delete">삭제</button>
				</div>
				
			<jsp:include page="../include/footer.jsp"/>
		</div>
	</div>
	
</body>
</html>