<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
		<style>
		* {
			margin: 0;
			padding: 0;
		}
		
		body {
			overflow: hidden;
			width: 1920px; /* 컨테이너 너비를 전체로 설정 */
		    background-image: url('/hos/resources/images/메인배경2.png');
		    background-size: cover;
		    background-position: center;
		    background-repeat: no-repeat;
		}
		
		#banner_insert_table {
			position: absolute; /* 절대 위치 */
			top: 50%; /* 화면의 50% 높이 */
			left: 50%; /* 화면의 50% 너비 */
			transform: translate(-50%, -50%); /* 중앙 정렬 */
			border-collapse: collapse; /* 테이블 테두리 간격 제거 */
			background: white; /* 테이블 배경색 */
		}
		
		th, td {
			padding: 10px; /* 셀 안쪽 여백 */
		}
		
		th {
			background-color: orange;
		}
		
		#name_input {
			border: none;
			outline: none;
		}
		
		.btn_style_1 {
			padding: 10px;
			border: none;
			color: white;
			font-weight: bold;
			background-color: orange;
			cursor: pointer;
		}
		
		.btn_style_2 {
			padding: 10px;
			border: none;
			color: black;
			font-weight: bold;
			background-color: white;
			border: 1px solid gray;
			cursor: pointer;
		}
		
		.btn_style_1:hover, .btn_style_2:hover {
			color: red;
		}
		</style>
		
		<script>
			function send(f) {
				if (f.banner_name.value === '') {
					alert("배너 이름을 입력하세요");
					return;
				}
				if (f.photo.value === '') {
					alert("사진을 선택하세요");
					return;
				}
		
				f.action = "insert_banner.do?pat_idx=${param.pat_idx}";
				f.submit();
			}
		</script>
	
	</head>
	<body>
		<div class="background">
		<form method="post" enctype="multipart/form-data">
			<table border="1" id="banner_insert_table">
				<tr>
					<th>배너이름</th>
					<td>
						<input placeholder="배너 이름을 입력하세요." name="banner_name" id="name_input">
					</td>
				</tr>
				<tr>
					<th>배너사진</th>
					<td><input type="file" name="photo"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
					<input type="button" value="배너 추가" class="btn_style_1" onclick="send(this.form);"> 
					<input type="button" value="취소" class="btn_style_2" onclick="history.back();"></td>
				</tr>
			</table>
		</form>
		</div>
	</body>
</html>





