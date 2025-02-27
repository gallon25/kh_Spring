<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style>
			#container{
				width: 1000px;
				margin: 0px auto;
				position:relative;}
		
			/* 페이지 */
			#page { position:absolute;
					bottom: 10px;
					left:500px;
					font-size:20px; }
					
			.comm_del_btn{
				width:50px;
				height:30px;
				background:#3086C9;
				color:white;
				border:none;
				margin: 0 0 0 950px;
				}
		</style>
	</head>
	
	
	<body>
		<div id="container">
			<!-- 댓글조회 div -->
			<div id="comment_list_div">
				<c:forEach var="vo" items="${comm_list}">	
					<form>			
					<input type="hidden" name="comm_idx" value="${vo.comm_idx}">
					<div class="comment_list">
						<img src="/hos/resources/images/profile.png">
						<p>${vo.comm_name} | ${vo.comm_date}</p><br>			
						<pre>${vo.comm_content}</pre>
						
						<c:if test="${param.pat_idx	eq vo.pat_idx}">
						
							<input type="button" class="comm_del_btn" value="삭제"
									onclick="comm_del(this.form);">
						</c:if>
						
						<hr>
					</div>
				</form>
				</c:forEach>
			</div>
			
			<div id="page">
					${ pageVolComm }
			</div>
		</div>
	</body>
</html>