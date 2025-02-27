<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 상세보기</title>
		
		<style>
			/* 큰 틀 */
			#container{ width:1000px;
				 		margin: 150px auto; 
				 		position:relative; }
			/* 카테고리명 */	 		
			#container > p { font-size: 30px;
						   font-weight: bold;}
			
			/* 제목 */			   
			#title > p { font-size:25px;
						   text-align: center; }
					
			/* 날짜 */			
			#date > p { color:gray;
						margin: 5px;
						text-align:right;  }		
					   
			/* 내용 */
			#content > pre { font-size:18px; }
			
			/* 이미지 */
			#img { text-align:center; }
			#img img { width:800px;
					   height:600px; }
					   
			/* 이전글, 다음글 */
			#pre_next_div { margin:20px 0; }
			
			#pre_next_div table { border-collapse:collapse;
								  width:1000px;
								  height:100px; }
			
			#pre_next_div table tr { border-top:1px solid gray;
									 border-bottom:1px solid gray; }
									 
			#pre_next_div table a { text-decoration:none;
									color:black; }
				
			/* 목록으로 버튼 */	
			#back_btn {
				background: #3086C9;
				border:none;
				color:white;
				height:50px;
				width: 70px;
				font-size:15px;
				margin: 50px auto;}				 
			
		</style>
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="container">
			<p>병원뉴스</p>
			
			<hr>
			
			<div id="title">
				<p>${vo.not_title}</p>
			</div>
			
			<hr>
			
			<div id="date">
				<p>작성일 : ${fn:split(vo.not_date, ' ')[0] }</p>
			</div>
			
			<hr>
			
			<div id="content">
				<pre>${vo.not_content}</pre>
			</div>
			
			<div id="img">
				<!-- 경로 설정 해야됨 -->
				<img src="/hos/resources/images/${vo.not_file}">
			</div>
			
			<div id="pre_next_div">
				<table>
					<tr>
						<th>이전글</th>
						<td>
							<c:if test="${preNotice ne null}">
								<a href="info_notice_view.do?not_idx=${preNotice.not_idx}&page=${param.page}">${preNotice.not_title}</a>						
							</c:if>
							
							<c:if test="${preNotice eq null }">
								이전 글이 존재하지 않습니다.
							</c:if>
						</td>
					</tr>
					
					<tr>
						<th>다음글</th>
						<td>
							<c:if test="${nextNotice ne null}">
								<a href="info_notice_view.do?not_idx=${nextNotice.not_idx}&page=${param.page}">${nextNotice.not_title}</a>							
							</c:if>
							
							<c:if test="${nextNotice eq null}">
								다음 글이 존재하지 않습니다.
							</c:if>
						</td>
					</tr>
				</table>
			</div>
			
			<div>			
				<input type="button" id="back_btn" value="목록으로"
					   onclick="location.href='info_notice_list.do?page=${param.page}'">
			</div>
			
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
		
	</body>
</html>