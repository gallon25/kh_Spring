<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료기기정보</title>
<style>
body {
	font-family: Interop;
	margin: 0;
	padding: 0;
	font-weight: normal;
    font-style: normal;
  	font-display: block;	
}

.header {
	padding: 0 20px;
	background-color: #12B8BA;
	color: white;
	display: flex;
	justify-content: space-between;
	align-items: center;
	height: 60px; /* 고정 높이 설정 */
}

.header h1 {
	margin: 0;
	font-size: 24px;
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
	padding: 0px 20px;
	background-color: #fff;
	border-bottom: 1px solid #ddd;
	margin-bottom: 20px;
	height: 60px; /* 고정 높이 설정 */
}

.info {
	font-size: 18px;
	color: #333;
}

.search {
	display: flex;
	align-items: center;
	font-size: 18px;
	position: relative; /* 위치 조정 가능 */
	left: -150px; /* 좌측으로 이동 */
}

.search select,
.search input,
.search button {
	margin-left: 10px;
	padding: 5px;
	font-size: 18px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.gallery-container {
	display: flex; /* Flexbox 활성화 */
	flex-wrap: wrap; /* 줄바꿈 허용 */
	gap: 15px; /* 카드 간의 간격 줄이기 */
	justify-content: space-around; /* 간격 균등 배치 */
	padding: 20px;
}

.device_box {
	width: 400px; /* 박스 너비 확대 */
	border: 1px solid #ccc;
	padding: 15px;
	text-align: center;
	/* box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 박스 그림자 */ 
	/*border-radius: 8px; /* 박스 모서리 둥글게 */ 
	background-color: #fff;
	font-size: 18px;
}

.device_box img {
	width: 100%; /* 이미지를 박스 너비에 맞춤 */
	height: 250px; /* 이미지 높이 설정 */
	object-fit: cover; /* 이미지가 박스에 맞게 자름 */
	border-radius: 4px;
}
</style>
<script>
function showPopup(devIdx) {
    // 팝업 창 URL에 의료기기 ID를 전달
    const popupUrl = "deviceInfo.do?dev_idx=" + devIdx;

    // 팝업 창 열기
    window.open(popupUrl, 'devicePopup', 'width=600,height=400,scrollbars=yes');
	}
</script>

</head>
<body>
<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>

<div class="header">
        <h1>
        <a href="${pageContext.request.contextPath}/device_list.do" style="color: white; text-decoration: none;">
            의료기기정보
        </a>
        </h1>
		<!-- 버튼 그룹 -->
	    <div class="button-group">
	        <button onclick="location.href='reservation_info_page.do'">예약안내</button>
	        <button onclick="">의료진찾기</button>
	    </div>
    </div>

	<div class="top-bar">
		<div class="info">총 게시물: 19개</div>
		<!-- 좌측 상단 -->
		<div class="search">
			<!-- 우측 상단 -->
			<form action="${pageContext.request.contextPath}/search.do"
				method="get">
				<select name="searchType">
					<option value="name">이름</option>
					<option value="content">내용</option>
					<option value="all">이름+내용</option>
				</select> <input type="text" name="keyword" placeholder="의료기기 검색...">
				<button type="submit">검색</button>
			</form>
		</div>
	</div>
	
<div class="gallery-container">
	<c:forEach var="vo" items="${list}">
		<div class="device_box">
			<c:if test="${vo.dev_filename ne 'no_file'}">
				<img
					src="${pageContext.request.contextPath}/resources/upload/${vo.dev_filename}">
				
				<!-- 확장자 제거 -->
				<c:set var="fileNameNoExtension" value="${fn:substringBefore(vo.dev_filename, '.png')}" />
				
				<!-- 숫자와 언더바 제거 -->
				<c:set var="formattedFileName" value="${fn:replace(fileNameNoExtension, '_', ' ')}" />
				<c:set var="cleanFileName" value="${fn:replace(formattedFileName, '^[0-9]+ ', '')}" />

				<!-- 출력 -->
				<a onclick="showPopup('${vo.dev_idx}');">${cleanFileName}</a>
			</c:if>
		</div>
	</c:forEach>
</div>

	<div align="center" style="margin-top: 20px; margin-bottom: 50px;">
		<p>${pageMenu}</p>
	</div>

</body>
</html>