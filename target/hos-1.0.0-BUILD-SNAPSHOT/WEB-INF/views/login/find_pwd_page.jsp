<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>비밀번호 변경</title>
	
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
	
		#main_div hr{
			width: 980px;
			margin: 30px auto;
			background: #12B8BA;
		}
		
		#main_title{
			display: block;
			margin: 20px 0;
			font-size: 24px;
		}	
		
		#sub_title{
			display: block;
			margin-top: 10px;
			font-size: 18px;
		}
		
		#main_div input {
			border: 1px solid #E2E2E2;
			width: 320px;
			height: 40px;
			padding-left: 10px;
			padding-right: 10px;
		}
			
		#main_div{
			text-align: center;
		}
		#main_div table{
			width: 600px;
			margin: 0px auto;
		}
		#main_div table td{
			padding-bottom: 10px 0;
		}
		
		#main_div #pwd_btn,
		#main_div #back_btn{
			width: 150px;
			height: 40px;
			margin-top: 20px;
			background-color: #12B8BA;
			color: white;
			border: none;
		}
	</style>
	
	<script>
		function chk_pwd() {
			let pwd_new1 = document.getElementById("pwd_new1").value;
			let pwd_new2 = document.getElementById("pwd_new2").value;
			let pat_idx = ${ param.pat_idx };
			
			if(pwd_new1 == '' ||  pwd_new2 == ''){
				alert("비밀번호를 모두 입력하세요.");
				return;
			}
			
			if(pwd_new1 != pwd_new2) {
	        	alert("새 비밀번호가 일치하지 않습니다.");
	        	return;
	        }
			
			alert("비밀번호가 변경되었습니다.");
			location.href = 'login_update_pwd.do?pwd_new=' + pwd_new1 + "&pat_idx=" + pat_idx;
		}
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	<div id="main_div">
		<p id="main_title">비밀번호 변경</p>
		<p id="sub_title">비밀번호를 재설정하신 뒤 로그인 해주세요.</p>
		
		<hr>
		<table>
			<tr>
				<td>새 비밀번호</td>
				<td><input id="pwd_new1" type="password"></td>
			</tr>
			<tr>
				<td>새 비밀번호 확인</td>
				<td><input id="pwd_new2" type="password"></td>
			</tr>
		</table>

		<input id="pwd_btn" type="button" value="비밀번호 변경" onclick="chk_pwd();">		
		<input id="back_btn" type="button" value="취소" onclick="history.back();">
		
		<hr>
	</div>
</body>
</html>