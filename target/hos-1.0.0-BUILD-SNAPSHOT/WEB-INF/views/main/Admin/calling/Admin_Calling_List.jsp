<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<link rel="stylesheet" href="/hos/resources/css/admin/mainpage_admin.css">
		<link rel="stylesheet" href="/hos/resources/css/admin/calling/calling_list.css">
		<script src="/hos/resources/js/httpRequest.js"></script>
		<script>
			// 모든 체크박스를 선택/해제하는 함수
			function toggleCheckboxes(masterCheckbox) {
			    const checkboxes = document.querySelectorAll('table td input[type="checkbox"]');
			    checkboxes.forEach(checkbox => {
			        checkbox.checked = masterCheckbox.checked;
			    });
			}
			//=====================================================================================
			//체크된 상담예약 전체 삭제	
			function delete_calling_check(f) {
				// 체크된 체크박스 가져오기
			    const selectedCheckboxes = Array.from(f.querySelectorAll('input[name="calling_idx"]:checked'));
				
			 	// 유효성 검사: 체크된 체크박스가 없을 경우 경고
			    if (selectedCheckboxes.length === 0) {
			        alert("삭제할 항목을 선택해주세요.");
			        return;
			    }
				
				if(!confirm("정말 삭제하시겠습니까?")){
					return;
				}
				
			 	// 체크된 체크박스의 값 가져오기
			    const selectedValues = selectedCheckboxes.map(checkbox => checkbox.value);
				
				let url = "delete_calling_check.do";
				let param = "calling_idx=" + selectedValues.join(",");
				
				sendRequest(url, param, delete_checkFn, "GET");	
			}
			function delete_checkFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
			        if (json[0].result == "succ") {
			            alert("삭제가 완료되었습니다.");
			            location.href="admin_calling_list.do";
			        } else {
			            alert("삭제 중 오류가 발생했습니다.");
			        }
				}
			}
			//=====================================================================================
			//상담예약 여부 수정	
			function update_calling_chk(calling_idx) {
				if(!confirm("해당 예약 여부를 수정하시겠습니까? \n" + "수정한 뒤에는 다시 수정하실 수 없습니다.")){
					return;
				}
				
				let url = "update_calling_chk.do";
				let param = "calling_idx=" + calling_idx;
				
				sendRequest(url, param, updateFn, "GET");
			}
			function updateFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
			        if (json[0].result == "succ") {
			            alert("해당 예약여부 수정완료");
			            location.href="";
			        } else {
			            alert("수정 중 오류가 발생했습니다.");
			        }
				}
			}
		</script>
	</head>
	<body>
		<!-- 헤더,사이드바 -->
		<jsp:include page="/WEB-INF/views/main/Admin/Admin_Header.jsp"/>
		
		<!-- 콘텐츠 영역 -->
		<div class="admin-content-container">
			<div class="admin-content" id="admin-content">
				<div id="container">
					<center>
					<p>상담예약</p>
					</center>
					
					<div id="calling_div">
						<form>
							<table>
								<colgroup>
								    <col width="5%">
								    <col width="25%">
								    <col width="25%">
								    <col width="45%">
								</colgroup>
							
								<tr>
									<th><input type="checkbox" onclick="toggleCheckboxes(this)" style="margin-left: 14px;"></th>
									<th>상담고객</th>
									<th>전화번호</th>
									<th>상담진행</th>
								</tr>
								
								<c:forEach var="vo" items="${list}" varStatus="count">
									<tr>
										<td><input type="checkbox" name="calling_idx" value="${vo.calling_idx}"></td>
										<td>${vo.calling_name}</td>
										<td>${vo.calling_tel}</td>
										<td>
								            <c:if test="${vo.calling_chk == 0}">
								                상담진행 미완료
											<input type="button" value="수정하기" class="buttons" 
												style="background-color: white; border: 1px solid #3086C9; color: #3086C9; margin-left: 10px;"
													onclick="update_calling_chk(${vo.calling_idx});">
								            </c:if>
								            <c:if test="${vo.calling_chk == 1}">
								                상담진행 완료
								            </c:if>
								        </td>
									</tr>
								</c:forEach>
							</table>
							<input type="button" value="체크한 상담 삭제" onclick="delete_calling_check(this.form);"
								 class="buttons" style="width: 150px;">
						</form>
					</div>
				</div>
			</div>
		</div>
		
	</body>
</html>

