<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <title>Insert title here</title> -->
<title>질병 목록</title>
<style>
body {
	font-family: Interop;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
	font-size: 18px;
}

.title {	
	padding: 0 20px; /* 수평 패딩만 추가 */
	background-color: #12B8BA;
	color: white;
	display: flex;
	justify-content: space-between;
	align-items: center;
	height: 60px; /* 고정 높이 설정 */
}

.title h1 {
	margin: 0;
	font-size: 24px;
	font-family: Interop;
}

/* 버튼 그룹 */
.button-group {
	display: flex;
	gap: 10px; /* 버튼 간격 */
	background-color: #3086C9; /* 버튼 영역 배경색 */
	padding: 0 10px; /* 버튼 영역 패딩 */
	height: 100%; /* 부모 높이와 동일 */
	align-items: center; /* 버튼 수직 정렬 */
	position: relative; /* 위치 조정 가능 */
	left: -300px; /* 좌측으로 이동 */
}

.button-group button {
	background-color: #3086C9; /* 버튼 배경색 */
	color: white;
	border: none;
	padding: 0 20px; /* 수평 패딩만 추가 */
	border-radius: 5px;
	cursor: pointer;
	font-size: 24px; /* 글자 크기 */
	font-family: Interop;
	height: 100%; /* 부모 높이와 동일 */
}

.button-group button:hover {
	background-color: #23507B; /* 호버 시 색상 변경 */
}

.top-bar {
	display: flex;
	justify-content: space-between; /* 좌우 정렬 */
	align-items: center; /* 수직 정렬 */
	padding: 0 20px;
	background-color: #fff;
	border-bottom: 1px solid #ddd;
	margin-bottom: 20px;
	font-size: 18px;
	height: 60px; /* 고정 높이 설정 */
}

.diagnosis-box {
	width: 1200px;
	height: 550px;
	background-color: white;
	border: 1px solid #ccc;
	border-radius: 5px;
	padding: 10px;
	/* overflow-y: auto;  세로 스크롤바 추가  */
	overflow: auto; /* 내용 넘칠 시 스크롤 */
	/* margin-left: 20px; /* 왼쪽 여백 추가 */
	margin: 0 auto; /* 좌우 마진을 auto로 설정 */
}
h2 {
    margin-bottom: 20px; /* 제목 아래에 20px 간격 추가 */
    font-size: 24px;
    font-weight: normal;
	font-style: normal;
    font-display: block;
}
table {
	width: 100%;
	border-collapse: collapse;
	font-size: 18px; /* 글자 크기 줄임 */
}

td {
	padding: 4px;
	text-align: left;
	border: none; /* 테두리 제거 */
	font-size: 18px; /* 셀 텍스트 크기 */
	word-break: break-word; /* 긴 텍스트 줄바꿈 */
}

td::before {
	content: "●"; /* 원모양 기호 추가 */
	color: black; /* 원의 색상 */
	margin-right: 8px; /* 원과 텍스트 간격 */
	font-size: 10px; /* 원 크기 */
}
</style>

<script>
function showPopup(illIdx) {
    // 팝업 창 URL에 질병 ID를 전달
    const popupUrl = "diseaseInfo.do?ill_idx=" + illIdx;

    // 팝업 창 열기
    window.open(popupUrl, 'diseasePopup', 'width=600,height=400,scrollbars=yes');
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	<div class="title">
		<h1>자가진단 서비스</h1>
		 <!-- 버튼 그룹 -->
	    <div class="button-group">
	        <button onclick="location.href='reservation_info_page.do'">예약안내</button>
	        <button onclick="">의료진찾기</button>
	    </div>
	</div>	
	
	<div class="top-bar">
	자가진단은 사용자 스스로 건강진단을 할 수 있는 항목들과 결과에 대한 건강 콘텐츠를 통해 건강실천사항을 제공하고 있습니다.
	</div>
	
	<div class="diagnosis-box">
		<h2>일반적인 증상</h2>
		<table>
			<tbody>
				<c:forEach var="vo" items="${list}" varStatus="status">
					<c:if test="${status.index % 4 == 0}">
						<tr>
					</c:if>
					<td>
						<!-- 질병 이름을 클릭하면 팝업을 띄움 --> <a
						onclick="showPopup('${vo.ill_idx}');">${vo.ill_name}</a>
					</td>
					<c:if test="${status.index % 4 == 3}">
						</tr>
					</c:if>
					<c:if test="${status.index >= 52}">
						<!-- 여기서 반복 종료 -->
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>