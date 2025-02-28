<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

			p{
				margin: 10px;
			}

			#title{
				font-size: 20px;
			}
			
			#btn{
				text-align: center;
				margin: 10px;
			}
			input{
				border: none;
				width: 150px;
				height: 40px;
				background-color: gray;
				color: white;
			}
		</style>
	</head>
	<body>
		<div id="main_div">
			<a id="detail_text">나의 작성글</a>
			<hr id="title_hr">
			
			<p id="title">다들 너무 친절하게 치료해주셔서 감사했습니다!</p>
			<p>2024-12-1 | 고결</p>
			
			<p><b>접수구분</b>&emsp;감사합니다</p>
			<p><b>연락처</b>&emsp;010-1111-2222</p>
			<hr>
			
			<p>덕분에 빠르게 회복할 수 있었습니다 ~ ^^</p>
			<hr>
			
			<div id="btn">
				<input type="button" value="수정" onclick="location.href='modify_post.do'">
				<input type="button" value="삭제">
			</div>
		</div>
	</body>
</html>