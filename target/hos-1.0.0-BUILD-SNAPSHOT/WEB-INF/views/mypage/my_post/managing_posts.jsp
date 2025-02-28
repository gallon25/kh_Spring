<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>작성글 관리</title>
		
		<style>
			@font-face {
			  font-family: 'Interop';
			  src: url('https://raw.githubusercontent.com/payw-org/Interop/main/web/fonts/Interop-Regular.woff2')
			      format('woff2'),
			      url('https://raw.githubusercontent.com/payw-org/Interop/main/web/fonts/Interop-Regular.woff')
			      format('woff');
			  font-weight: normal;
			  font-style: normal;
			  font-display: block;
			}
			
			*{margin: 0; padding: 0; font-family: 'Interop'; font-weight: 300; font-size: 18px;}
		
			#main_div{
				width: 1000px;
				margin: 20px auto;
			}
			
			#post_text{
				display: block;
				font-size: 40px;
				margin-bottom: 30px;
			}
			
			#main_div table{
				width: 1000px;
				margin-top: 20px;
				border-collapse: collapse;
				font-size-adjust: 20px;
			}
			#main_div table th, td{
				text-align: center;
				padding: 10px; 
			}
			#main_div table th{
				border-top: 2px solid gray;
				border-bottom: 2px solid gray;
			}
			#main_div table td{
				border-bottom: 1px solid gray;
			}
			.title{
				text-align: left;
			}
			
			#main_div a{
				text-decoration: none;
			}
			#main_div a:hover {
				font-weight: bold;
			}
		</style>
		
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="main_div">
			<p id="post_text">작성글 관리</p>

			<table>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>카테고리</th>
				</tr>
				
				<c:forEach var="vo" items="${ list }">
				<tr>
					<td>${ vo.board_idx }</td>
					<td class="title">
						<a href="mypage_detail_post.do?board_idx=${ vo.board_idx }">
							${ vo.board_title }
						</a>
					</td>
					<td>${ vo.board_date }</td>
					<td>
						<c:if test="${ vo.board_type eq 'thanks' }">감사합니다</c:if>
						<c:if test="${ vo.board_type ne 'thanks' }">건의합니다</c:if>
					</td>
				</tr>
				</c:forEach>
			</table>
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>