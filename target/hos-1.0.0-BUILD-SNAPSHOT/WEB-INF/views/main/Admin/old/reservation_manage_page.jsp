<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script src="/hos/resources/js/httpRequest.js"></script>
		<link rel="stylesheet" href="/hos/resources/css/reservation_manage_main.css?v=1.0">

		<script>
			//예약삭제
			function reservation_delete(res_idx) {
				if(!confirm("해당 예약을 삭제하시겠습니까?")){
					return;
				}	
				
				let url = "reservation_delete.do";
				let param = "res_idx=" + res_idx;
				
				sendRequest(url, param, reservation_delFn, "GET");
			}
			
			function reservation_delFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if(json[0].result == "succ"){
						alert("예약을 삭제했습니다.");
						location.href="reservation_ManagePage.do";
						return;
					}else{
						alert("오류로 예약삭제에 실패했습니다.");
					}//inner
				}//outer
			}
			//====================================================================
			//검색
			function search() {
				//검색어
				let search_text = document.getElementById("search_text").value;
								
				//유효성 체크
				if(search_text === ''){
					alert("검색할 내용을 입력하세요");
					return;
				}
								
				location.href="reservation_ManagePage.do?search_text=" + search_text;
			}
		</script>
	</head>
	<body>
	    <center>
		    <div id="container"> 
				<h1 style="display: inline-block; float: left;">예약관리</h1>
				
				<div style="display: inline-block; float: right;">
					<input placeholder="환자의 이름을 입력해 주세요" id="search_text"
						style="width: 180px; height: 35px; outline: none;">
					<input type="button" value="검색" class="btn_style_1" onclick="search();">
				</div>
				
				<table id="reservation_table">
					<tr>
						<th>예약번호</th>
						<th>환자이름</th>
						<th>교수이름(진료과)</th>
						<th>예약날짜</th>
						<th>예약여부</th>
						<th>결제여부</th>
						<th>예약수정</th>
					</tr>
					<c:forEach var="vo" items="${res_list}">
						<tr>
							<td>${vo.res_idx}</td>				
							<td>${vo.pat_name}</td>				
							<td>${vo.pro_name}(${vo.dept_name})</td>				
							<td>${vo.res_time.substring(0, 10)}<br>
							${vo.res_time.substring(10, 16)}</td>
							
							<!-- 예약 여부 -->
							<c:if test="${vo.res_chk eq 1}">
								<td style="color: green;">예약완료</td>
							</c:if>	
							<c:if test="${vo.res_chk eq 0}">
								<td style="color: #d2d2d2;">예약취소</td>
							</c:if>	
							
							<!-- 결제 여부 -->
							<c:if test="${vo.pay_chk eq 1}">
								<td style="color: green;">결제완료</td>
							</c:if>	
							<c:if test="${vo.pay_chk eq 0}">
								<td style="color: red;">결제미완료</td>
							</c:if>	
							
							<!-- 수정 버튼 -->
							<td>
								<input type="button" value="수정하기" class="btn_style_1" style="width: 100px;"
									onclick="location.href=
										'reservation_update_page.do?res_idx=${vo.res_idx}&pat_name=${vo.pat_name}&pro_name=${vo.pro_name}&dept_name=${vo.dept_name}'">
								<input type="button" value="삭제하기" class="btn_style_2" style="width: 100px;"
									onclick="reservation_delete(${vo.res_idx});">		
							</td>	
						</tr>
					</c:forEach>
					
					<tr>
						<td colspan="7">
							${ pageMenu }
						</td>
					</tr>
					<tr>
						<td colspan="7">
							<form action="main.do" method="get">
							    <input type="hidden" name="pat_id" value="${sessionScope.patient.pat_id}">
							    <input type="submit" value="메인으로 돌아가기" class="btn_style_2"
							    	style="float: left;">
							</form>
							
							<input type="button" value="예약추가 >>" class="btn_style_1"
								style="float: right; margin: 5px; padding: 10px;">
						</td>
					</tr>
				</table>
		    </div>  
	    </center>
	    
	</body>
</html>






