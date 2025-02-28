<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원 정보 수정</title>
		
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
				height: 1000px;
				margin: 0px auto;
			}
			
			#update_text{
				display: block;
				font-size: 40px;
				font-weight: 500;
				margin: 20px 0px;
			}
			
			/* hr태그 */					
			hr{
				width: 1000px;
			}
			
			/* 비밀번호 변경, 기본정보 변경 button ====================================================*/
			#btn_div{
				position: relative;
			}
			#btn_div input{
				width: 500px;
				height: 55px;
				border: none;
				border-bottom: 2px solid #12B8BA !important;
				transition: all 0.2s ease;
			}
			
			#change_pwd_btn{
				background-color: #12B8BA;
				color: white;
				position: absolute;
			}
			#change_info_btn{
				background-color: white;
				color: black;
				position: absolute;
				left: 500px;
			}
			
			/* 비밀번호 변경에 속한 태그들 ====================================================*/
			#update_pwd{
				text-align: center;
				position: absolute;
				top: 250px;
			}
			#update_pwd #title{
				font-size: 24px;
				margin: 20px;
			}
			#update_pwd #sub_title{
				font-size: 15px;
				margin: 20px;
			}
			#update_pwd #pat_name{
				color: #3086C9;
			}
			
			#update_pwd input {
				border: 1px solid #E2E2E2;
				width: 320px;
				height: 40px;
				padding-left: 10px;
				padding-right: 10px;
			}
			
			#update_pwd table{
				width: 600px;
				margin: 20px auto;
			}
			#update_pwd hr{
				width: 1000px;
				height: 1px;
				margin: 0px auto;
				border: none;
				background: #D2D2D2;
			}
			
			#update_pwd #pwd_btn, 
			#update_pwd #back_btn{
				border: none;
				width: 150px;
				height: 40px; 
				border: 1px solid lightgray;
				background-color: white;
				margin-bottom: 20px;
			}
			
			/* 기본정보 변경에 속한 태그들 ====================================================*/
			#update_infomation{
				text-align: center;
				position: absolute;
				top: 270px;
			}
			#update_infomation table{
				text-align: left;
				border-collapse: collapse;
				margin: 10px auto;
				width: 1000px;
			}
			#update_infomation table th, td{
				padding: 15px 10px;
			}
			#update_infomation table th{
				padding-left: 45px;
				width: 200px;
			}
			#update_infomation table tr{
				border-top: 1px solid #D2D2D2; 
			}
			
			/* input[type="text"] 태그 - 모든 태그 기본설정 */
			#update_infomation input {
				border: 1px solid #E2E2E2;
				width: 250px;
				height: 35px;
				padding-left: 10px;
				padding-right: 10px;
			}
			
			/*중복확인 버튼, 주소찾기 버튼 */
			#update_infomation #address_btn{
				border: none;
				width: 130px;
				height: 38px;
				color: white;
				background-color: #12B8BA;
			}
			
			/* input[type="text"] 태그 - 이메일 */
			#update_infomation .email{
				width: 200px;	
			}
			/* option 태그 - 이메일주소 */
			#update_infomation #email_addr{
				border: 1px solid #E2E2E2;
				height: 40px;
				width: 120px;
				padding-left: 10px;
				padding-right: 10px;
			}
			
			/* input[type="text"] 태그 - 주소 */
			#update_infomation #address_post{
				width: 120px;
			}
			#update_infomation #address_detail, 
			#update_infomation #address_road{
				width: 400px;
				margin-top: 10px;
			}

			/* option 태그 - 전화번호 */
			#update_infomation .pat_phone{
				border: 1px solid #E2E2E2;
				height: 40px;
				width: 80px;
				padding-left: 10px;
				padding-right: 10px;
			}
			
			/* 성별 선택 radio */
			#update_infomation .gender{
				width: 40px;
				height: 20px;
				accent-color: #3086C9;
			}
			
			/* 가입취소, 회원가입 버튼 */
			#update_infomation #back_btn,
			#update_infomation #reg_btn {
				border: none;
				width: 150px;
				height: 40px; 
				border: 1px solid lightgray;
				background-color: white;
				margin: 20px 0;
			}
			
			#update_infomation .essential{
				font-size: 10px;
				color: red;
			}
		</style>
		
		<script>
			//비밀번호 변경 <-> 회원정보 수정 모드 변경
			function change_mode( id ) {
				let pwd_btn = document.getElementById("change_pwd_btn");
				let info_btn = document.getElementById("change_info_btn");
				
				let update_pwd = document.getElementById("update_pwd");
				let update_infomation = document.getElementById("update_infomation");
				
				if( id == "change_pwd_btn") {//비밀번호 변경 버튼을 누른 경우 
					pwd_btn.style.backgroundColor = "#12B8BA";
					pwd_btn.style.color = "white";
					info_btn.style.backgroundColor = "white";
					info_btn.style.color = "black";
					
					update_infomation.style.display = "none";
					update_pwd.style.display = "block";
				}
				else {//비밀번호 변경 버튼을 누른 경우 
					info_btn.style.backgroundColor = "#12B8BA";
					info_btn.style.color = "white";
					pwd_btn.style.backgroundColor = "white";
					pwd_btn.style.color = "black";
					
					update_pwd.style.display = "none";
					update_infomation.style.display = "block";
				}
			}
		
			//두개의 비밀번호가 일치하는지 체크하는 함수
			function chk_pwd() {
				//현재 비밀번호
				let pwd = ${ vo.pat_pwd };
				//비밀번호 입력값
				let pwd_now = document.getElementById("pwd_now").value;
				
				//새 비밀번호
				let pwd_new1 = document.getElementById("pwd_new1").value;
		        let pwd_new2 = document.getElementById("pwd_new2").value; 
				
		        if(pwd_new1 == '' || pwd_new2 == ''){
		        	alert("빈칸을 모두 입력하세요.");
		        	return;
		        }
		        
				if(pwd != pwd_now){
					alert("현재 비밀번호와 일치하지 않습니다.");
					return;
				}   
		        
		        if(pwd_new1 != pwd_new2) {
		        	alert("새 비밀번호가 일치하지 않습니다.");
		        	return;
		        }
		        
		        location.href = 'mypage_update_pwd.do?pwd_new=' + pwd_new1 +"&pat_idx=" + ${ vo.pat_idx };
			}
			
			//이메일 주소에 따라 input text 값 변경하는 함수
			function chk_email() {
			    let email_addr = document.getElementById("email_addr");
			    let email_addr2 = document.getElementsByName("pat_email_addr")[0];
			    
			    if (email_addr.options[email_addr.selectedIndex].value != "") {
			    	email_addr2.value = email_addr.options[email_addr.selectedIndex].value;
			    }
			}
			
			function update_info( f ) {
				//유효성체크
				let pat_email = document.getElementsByName("pat_email")[0].value;
				let pat_email_addr = document.getElementsByName("pat_email_addr")[0].value;
				let pat_address_post = document.getElementsByName("pat_address_post")[0].value;
				let pat_address_road = document.getElementsByName("pat_address_road")[0].value;
				let pat_address_detail = document.getElementsByName("pat_address_detail")[0].value;
				let pat_phone = document.getElementsByName("pat_phone")[0].value;
				let pat_phone1_1 = document.getElementsByName("pat_phone1_1")[0].value;
				let pat_phone1_2 = document.getElementsByName("pat_phone1_2")[0].value;
				
				if(pat_email == '' || pat_email_addr == '' ||
				   pat_address_post == '' || pat_address_road == '' || pat_address_detail == '' ||
				   pat_phone == '' || pat_phone1_1 == '' || pat_phone1_2 == '') {
					alert("빈칸을 모두 입력해주세요.");
					return;
				}
				
				alert("정보수정이 완료되었습니다.");
				
				f.method = "post";
				f.action = "mypage_update_info.do";
				f.submit();
			}
			
		</script>
	</head>
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="main_div">
			<a id="update_text">회원정보수정</a>
			
			<div id="btn_div">
				<input id="change_pwd_btn" type="button" value="비밀번호 변경" onclick="change_mode('change_pwd_btn');">
				<input id="change_info_btn" type="button" value="기본정보 변경" onclick="change_mode('change_info_btn');">
			</div>
			
			<!-- 비밀번호 변경 -->			
			<div id="update_pwd">
				<p id="title">비밀번호 변경</p>
				<p id="sub_title"><a id="pat_name">고결</a> 회원님의 소중한 개인정보의 보호를 위하여 비밀번호를 변경해 주시기 바랍니다.</p>
				
				<hr>
				<table>
					<tr>
						<td>현재 비밀번호</td>
						<td><input id="pwd_now" type="password"></td>
					</tr>
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
			
			<!-- 기본정보 변경 -->			
			<div id="update_infomation" style="display:none">
				<form>
					<input type="hidden" name="pat_idx" value="${ vo.pat_idx }">
					<input type="hidden" name="pat_name" value="${ vo.pat_name }">
					<input type="hidden" name="pat_pwd" value="${ vo.pat_pwd }">
				 
					<table>
						<tr style="border-top: 2px solid #C2C2C2">
							<th>이름</th>
							<td>${ vo.pat_name }</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>${ vo.pat_id }</td>
						</tr>
						
						<!-- 이메일 ================================================== -->
						<tr>
						    <th>이메일<a class="essential">*</a></th>
						    <td>
						        <input class="email" name="pat_email" value="${fn:split(vo.pat_email, '@')[0]}">
						        <a>	@ </a>
						        <input class="email" name="pat_email_addr" value="${fn:split(vo.pat_email, '@')[1]}">
						        
						        <select id="email_addr" name="pat_email_addr" onchange="chk_email();">
						            <option value="">직접입력</option>
						            <option value="gmail.com">gmail.com</option>
						            <option value="hanmail.net">hanmail.net</option>
						            <option value="naver.com">naver.com</option>
						            <option value="nate.com">nate.com</option>
						        </select>
						    </td>
						</tr>
						
						<!-- 주소 ================================================== -->
						<tr>
							<th>주소<a class="essential">*</a></th>
							<td>
								<input id="address_post" name="pat_address_post" value="${ vo.pat_address_post }">
								
								<input id="address_btn" type="button" value="주소찾기" onclick="find_address();"><br>
								
								<input id="address_road" name="pat_address_road" value="${ vo.pat_address_road }"><br>
								<input id="address_detail" name="pat_address_detail" value="${ vo.pat_address_detail }" placeholder="상세 주소를 입력하세요">
							</td>
						</tr>
						
						<!-- 연락처 ================================================== -->
						<tr>
							<th>연락처<a class="essential">*</a></th>
							<td> 
								<select class="pat_phone" name="pat_phone" defaultValue="${fn:split(vo.pat_phone,'-')[0]}">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select> - 
								<input class="pat_phone" name="pat_phone1_1" maxlength="4" value="${fn:split(vo.pat_phone,'-')[1]}"> -
	
								<input class="pat_phone" name="pat_phone1_2" maxlength="4" value="${fn:split(vo.pat_phone,'-')[2]}">
							</td>
						</tr>
						<tr>
							<th>비상연락처</th>
							<td>
								<select class="pat_phone" name="pat_phone2">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select> - 
								<input class="pat_phone" name="pat_phone2_1" value="${fn:split(vo.pat_phone2,'-')[1]}"> -
								<input class="pat_phone" name="pat_phone2_2" value="${fn:split(vo.pat_phone2,'-')[2]}">
							</td>
						</tr>
						<tr>
							<th>생년월일</th>
							<%-- <td><input type="date" name="pat_birthday" value="${vo.pat_birthday}"></td> --%>
							<td><input type="date" name="pat_birthday" 
								 value="${ fn:split(vo.pat_birthday, ' ')[0] }"></td>
							
						</tr>
						<tr style="border-bottom: 2px solid #C2C2C2">
							<th>성별</th>
							<td>
								<input class="gender" type="radio" name="pat_gender" value="남자"
									${vo.pat_gender == '남자' ? 'checked' : ''}>남자
								<input class="gender" type="radio" name="pat_gender" value="여자"
									${vo.pat_gender == '여자' ? 'checked' : ''}>여자
							</td>
						</tr>
					</table>
	
					<input id="reg_btn" type="button" value="기본정보수정" onclick="update_info(this.form);">
					<input id="back_btn" type="button" value="취소" onclick="history.back();">
				</form>

			</div> <!-- update_infomation -->
			
		</div> <!-- main_div -->
	</body>
	
	<!-- 주소 API -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function find_address() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("address_detail").value = extraAddr;
	                
	                } else {
	                    document.getElementById("address_detail").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('address_post').value = data.zonecode;
	                document.getElementById("address_road").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("address_detail").focus();
	            }
	        }).open();
	    }
	</script>
</html>