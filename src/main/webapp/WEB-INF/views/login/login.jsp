<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
		
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
				text-align: center;
			}
			
			#login_div img{
				width: 150px;
			}
			
			#login_text{
				display: block;
				margin: 20px 0px;				
				font-size: 40px;
			}
			#login_sub_text{
				display: block;
				margin: 20px 0px;				
				font-size: 18px;
				color: gray;
			}
			
			#login_form input{
				display: block;
				margin: 10px auto;
			}
			
			#login_div input {
				border: 1px solid gray;
				width: 400px;
				height: 50px;
				font-size: 18px;
				padding-left: 10px;
				padding-right: 10px;
			}
			
			#main_div input[type="button"]{
				display: block;
				width: 425px;
				height: 50px;
				border: none;
			}
			
			#login_btn{
				margin: 0px auto;
				margin-top: 10px;
				color: white;
				background-color: #12B8BA;
			}
			
			#btn_div{
				margin: 10px auto;
			}
			#btn_div .btn:hover{
				color: #3086C9;
			}
			
		</style>
		
		<script src="/hos/resources/js/httpRequest.js"></script>
		<script>
			function login() {
				let pat_id = document.getElementsByName("pat_id")[0].value;
				let pat_pwd = document.getElementsByName("pat_pwd")[0].value;
				
				//유효성검사
				if(pat_id == ''){
					alert("아이디를 입력하세요.");
					return;
				}
				if(pat_pwd == ''){
					alert("비밀번호를 입력하세요.");
					return;
				}
				
				let url = "login_chk_correct.do";
				let param = "pat_id=" + pat_id + "&pat_pwd=" + pat_pwd;
				sendRequest(url, param, login_result_fn, "post");
			}
			function login_result_fn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if(json[0].result == "id_not_exist"){
						alert("존재하지 않는 아이디 입니다.");
						return;
					}
					else if(json[0].result == "id_exist"){
						alert("비밀번호가 일치하지 않습니다.");
						return;
					} else {
						alert("로그인 성공");
						let pat_idx = json[1].pat_idx;
						location.href="main.do?pat_idx=" + pat_idx;
					}
				}
			}
		</script>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<!-- 로그인 메인 div -->
		<div id="main_div">
			<div id="login_div">
				<img src="/hos/resources/images/MEDICOMPILE LOGO.png">
				<a id="login_text">로그인</a>
				<a id="login_sub_text">MediCompile 홈페이지의 서비스는<br>로그인 후 이용하실 수 있습니다.</a>
				
				<form id="login_form">
					<input name="pat_id" placeholder="아이디를 입력해주세요" size="30">
					<input name="pat_pwd" type="password" placeholder="비밀번호를 입력해주세요" size="30">
					<input id="login_btn" type="button" value="로그인" onclick="login(this.form);">
				</form>
				
				<div id="btn_div">
					<a class="btn" type="button"onclick="location.href='login_find_id_form.do'">아이디 찾기</a>
					<a>|</a>
					<a class="btn" type="button"onclick="location.href='login_find_pwd_form.do'">비밀번호 찾기</a>
					<a>|</a>
					<a class="btn" type="button" onclick="location.href='register_page.do'">회원가입</a><br>
				</div>
			</div>  
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>