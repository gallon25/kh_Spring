<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
	</head>
	<body>
		<!-- 로그인을 안 한 경우 -->
		<c:if test="${param.pat_idx eq null or empty param.pat_idx}">
			<div id="content_login_before">
				<p id="login_message">
					로그인 하시면<br>
					더욱 다양한 혜택을<br>
					이용하실 수 있습니다.
				</p>	
				<div style="margin-left: 330px;">
					<input type="button" class="login_buttons" value="로그인" 
						style="width: 200px; margin-top: 30px;" onclick="location.href='login_page.do'"><br>
					<input type="button" class="login_buttons" value="회원가입" 
						style="width: 200px;  margin-top: 5px;" onclick="location.href='register_page.do'">	
				</div>
			</div>
		</c:if>
			
		<!-- 로그인을 한 경우 -->
		<c:if test="${param.pat_idx ne null and not empty param.pat_idx}">
			<div id="content_login_after">
				<p id="welcome_message">
				<strong>${sessionScope.patient.pat_name}</strong>님 환영합니다.<br>
				방문해 주셔서 감사합니다.
				</p>
				<div style="margin-left: 330px;">
					<input type="button" class="login_buttons" value="로그아웃" 
						style="width: 200px; margin-top: 30px;" onclick="logout(${param.pat_idx});"><br>
					<input type="button" class="login_buttons" value="예약확인" 
						style="width: 200px;  margin-top: 5px;" 
							onclick="location.href='mypage_reservation_list.do?pat_idx=${sessionScope.patient.pat_idx}'">
				</div>
			</div>	
		</c:if>
		
		<div id="content_hr">
		    <!-- 병원게시판 -->
		    <div class="section-header">
		        <p class="content_main_p">병원게시판 ></p>
		    </div>
		
		    <!-- 감사합니다! 전체보기, 글 쓰기 -->
		    <div class="section-reservation">
		        <a class="content_sub_p" href="join_thanks_list.do?pat_idx=${param.pat_idx}">감사합니다! 전체보기</a>
		        <a class="content_sub_p" href="join_thanks_insert_form.do?pat_idx=${param.pat_idx}">감사합니다! 글 쓰기</a>
		        <a class="content_sub_p" href="join_compl_insert_form.do">건의합니다. 글 쓰기</a>
		    </div>
		
		    <!-- 건의합니다, 자원봉사 모집공지, 공지사항 보기 -->
		    <div class="section-other">
		        <a class="content_sub_p" href="join_volunteer_list.do?pat_idx=${param.pat_idx}">자원봉사 모집공지</a>
		        <a class="content_sub_p" href="info_notice_list.do">공지사항 보기</a>
		    </div>
		</div>
	</body>
</html>




