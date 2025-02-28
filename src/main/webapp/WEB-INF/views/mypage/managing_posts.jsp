<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>작성글 관리</title>
		
		<style>
			#main_div{
				width: 1000px;
				margin: 0px auto;
			}
			#post_text{
				display: block;
				margin: 20px 10px;
				font-size: 25px;
			}
			
			table{
				width: 1000px;
				margin-top: 20px;
				border-collapse: collapse;
				font-size-adjust: 20px;
			}
			table th, td{
				text-align: center;
				padding: 10px; 
			}
			table th{
				border-top: 2px solid gray;
				border-bottom: 2px solid gray;
			}
			table td{
				border-bottom: 1px solid gray;
			}
			.title{
				text-align: left;
			}
			
			a{
				text-decoration: none;
			}
			a:hover {
				font-weight: bold;
			}
		</style>
		
	</head>
	<body>
		<div id="main_div">
			<a id="post_text">작성글 관리</a>

			<table>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>카테고리</th>
				</tr>
				
				<tr>
					<td>124</td>
					<td class="title">
						<a href="detail_post.do">
							다들 너무 친절하게 치료해주셔서 감사했습니다!
						</a>
					</td>
					<td>2024-12-1</td>
					<td>감사합니다</td>
				</tr>
				
				<tr>
					<td>125</td>
					<td class="title">
						<a href="#">진료 대기중 대기공간</a>
					</td>
					<td>2024-12-5</td>
					<td>건의합니다</td>
				</tr>
			</table>
		</div>
	</body>
</html>