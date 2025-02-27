<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>

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
		margin: 30px auto;
		text-align: center;
	}
	
	#main_div hr{
		width: 980px;
		margin: 10px auto;
		background: #12B8BA;
	}
		
	#main_div p{
		display: block;
		margin: 20px 0;
		font-size: 24px;
	}
	
	#main_div a{
		display: block;
		margin: 10px 0;
	}
	
	#main_div a b{
		font-weight: bold;
	}
	
	#sub_title{
		font-size: 15px;
		margin: 20px auto;
	}
	
	#main_btn, #login_btn {
		width: 150px;
		height: 40px;
		margin: 20px 0;
		background-color: #12B8BA;
		color: white;
		border: none;
	}
	
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	<div id="main_div">
		<hr>
	 	<p>아이디를 확인하신 후 로그인 해주시기 바랍니다.</p>
	 	<a>아이디 : <b>${ param.pat_id }</b></a>
	 	<input id="main_btn" type="button" value="메인으로 이동" onclick="location.href='main.do'">
	 	<input id="login_btn" type="button" value="로그인" onclick="location.href='login_page.do'">
		<hr>
	</div>
</body>
</html>