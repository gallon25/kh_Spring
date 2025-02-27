<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>나의 작성글</title>
		
		<style>
			*{margin:0px; padding:0px;}
		
			#main_div{
				width: 1000px;
				margin: 0px auto;
			}
			#detail_text{
				display: block;
				margin: 20px 10px;
				font-size: 25px;
			}
			
			#title_hr{
				border: 2px solid gray;
			}

			#main_div p{
				margin: 10px;
			}

			#title{
				font-size: 20px;
			}
			
			#btn{
				text-align: center;
				margin: 10px;
			}
			#main_div input{
				border: none;
				width: 150px;
				height: 40px;
				background-color: gray;
				color: white;
			}
		</style>
		
		<script>
		function delete_post(pat_idx) {
		    if (confirm("작성하신 글을 삭제하시겠습니까?")) {
		        location.href = 'mypage_delete_post.do?board_idx=' + '${param.board_idx}' + '&pat_idx=' + pat_idx;
		    }
		}

		</script>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="main_div">
			<a id="detail_text">나의 작성글</a>
			<hr id="title_hr">
			
			<p id="title">${ vo.board_title }</p>
			<p>${ vo.board_date } | ${ vo.board_name }</p>
			
			<p><b>접수구분</b>&emsp;
				<c:if test="${ vo.board_type eq 'thanks' }">감사합니다</c:if>
				<c:if test="${ vo.board_type ne 'thanks' }">건의합니다</c:if>
			</p>
			<p><b>연락처</b>&emsp;${ vo.board_phone }</p>
			<hr>
			
			<p>${ vo.board_content }</p>
			<hr>
			
			<div id="btn">
				<input type="button" value="수정" onclick="location.href='mypage_update_post_form.do?board_idx=${vo.board_idx}'">
				<input type="button" value="삭제" onclick="delete_post(${ vo.pat_idx });">
				<input type="button" value="목록" onclick="history.back();">
			</div>
		</div>
	</body>
</html>