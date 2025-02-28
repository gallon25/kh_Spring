<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>감사합니다 등록하기</title>
		
		<style>
			/* 큰 틀 */
			#container{ width:1000px;
				 		margin: 150px auto; }
				 		
			#container p { font-size: 30px;
						   font-weight: bold;}
			
			/* 테이블 */			   
			#container table { border-collapse:collapse;
							   align:center;
							   width:1000px; }
							   
			#container table tr { border-top: 1px solid gray; }
							   
			#container table th { width: 250px;
								  height: 50px;
								  color:#323232; }
								  
			#container table p { color:#3232FF;
								 font-size:13px; }
								 
			#container table tr:first-child { border-top: 3px solid black; }				 

			#container table .last_tr { border-bottom: 3px solid black; }				 
			
			#container table tr th, td { padding: 10px;}
				
			/* 입력창 */					 
			.name_txt { width: 180px;
						height: 30px;
						outline:none; }
						
			.board_phone_s { width: 90px; 
						   height: 34px; }
			
			.board_phone { width: 90px;
						 height: 30px;
						 outline:none; }
						 
			.email { width: 180px;
					 height:30px;
					 outline:none; }
					 
			#email_addr { width:100px;
						  height:34px; }
						 
			.title_txt { width: 500px;
						 height: 30px;
						 outline:none; }
			
			.content_txt { resize:none;
						   width:600px;
						   height:600px;
						   outline:none; }
						   
			.file_btn { background:white;
						border:1px solid gray;
						width: 500px;
						height: 34px; }		
						   
			/* 하단 버튼 묶음 div*/
			#btn_div { margin: 20px;
					   text-align:center; }
			
			.list_btn { background:white;
						width: 180px;
						height: 50px;
						font-size:15px;
						font-weight:bold;
						border:1px solid black; }
						
			.insert_btn { background: #4169E1;
						  width: 180px;
						  height: 50px;
						  font-size:15px;
						  font-weight:bold;
						  border:1px solid #4169E1;
						  color:white;}
			
						 
		</style>
		
		<script>
			function insert(f){
				      
				let board_name = f.board_name.value;
				let board_title = f.board_title.value;
				let board_content = f.board_content.value;
				
				let board_phone_1 = f.board_phone_1.value;
			    let board_phone_2 = f.board_phone_2.value;
			    
			    let board_email1 = f.board_email1.value;
			    let board_email2 = f.board_email2.value;

				
			    
			    //유효성체크
				if( board_name === '' ){
					alert("이름을 입력하세요.");
					return;
				}
				
				if( board_phone_1 === '' || board_phone_2 === '' ){
					alert("번호을 입력하세요.");
					return;
				} 
				
				if( board_email1 === '' || board_email2 === '' ){
					alert("이메일을 입력하세요.");
					return;
				}
				
				if( board_title === '' ){
					alert("제목을 입력하세요.");
					return;
				}
				
				if( board_content === '' ){
					alert("내용을 입력하세요.");
					return;
				}
				
				f.action = "join_board_insert.do?pat_idx=${param.pat_idx}";
				f.submit();
			}
			
			//이메일 select -> text로 옮기기
			function chk_email(email_addr){
				document.forms[0].board_email2.value = email_addr;
			}

		</script>
		
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<div id="container">
			<p>감사합니다</p>
			<form method="post"
				  enctype="multipart/form-data"
				  name="f">
				
				<input type="hidden" name="board_type" value="thanks">
				<input type="hidden" name="page" value="${param.page}">

				<table>
					<tr>
						<th>작성자 성함</th>
						<td>
							<input class="name_txt" name="board_name"/>
						</td>
					</tr>
					
					<tr>
						<th>휴대폰번호</th>
						<td> 
	                        <select class="board_phone_s" name="board_phone">
	                           <option value="010">010</option>
	                           <option value="011">011</option>
	                           <option value="016">016</option>
	                           <option value="017">017</option>
	                           <option value="018">018</option>
	                           <option value="019">019</option>
	                        </select> - 
	                        <input class="board_phone" name="board_phone_1"> -
	   
	                        <input class="board_phone" name="board_phone_2">
	                        <p class="text">연락가능한 전화번호를 입력 해 주시기 바랍니다.</p>
	                     </td>
					</tr>
			        
			        <tr>
                     <th>이메일</th>
	                     <td>
	                        <input class="email" name="board_email1">
	                        <a> @ </a>
	                        <input class="email" name="board_email2">
	                        
	                        <select id="email_addr" onchange="chk_email(this.value);">
	                           <option value="">직접입력</option>
	                           <option value="gmail.com">gmail.com</option>
	                           <option value="hanmail.net">hanmail.net</option>
	                           <option value="naver.com">naver.com</option>
	                           <option value="nate.com">nate.com</option>
	                        </select>
	                     </td>
                 	 </tr>
					
					<tr>
						<th>제목</th>
						<td>
							<input class="title_txt" name="board_title"/>
						</td>
					</tr>
					
					<tr>
						<th>내용</th>
						<td>
							<textarea class="content_txt" name="board_content" placeholder="한글 4000자 입력 가능합니다."></textarea>
						</td>
					</tr>
					
					<!-- jpg, png (이미지)파일만 첨부 가능 -->
					<tr class="last_tr">
						<th>파일첨부</th>
						<td>
							<input type="file" class="file_btn" 
								   name="photo" accept="image/gif, image/jpeg, image/png"/>
							<p>JPG, PNG 파일만 첨부 가능합니다. (5MB 이하)파일이름은 영문으로 작성해 주시기 바랍니다.</p>
						</td>
					</tr>
					
				</table>
				
				<div id="btn_div">
					<input class="list_btn" type="button" value="감사합니다 전체보기"
						   onclick="location.href='join_thanks_list.do'"/>
					<input class="insert_btn" type="button" value="확인" 
						   onclick="insert(this.form);"/>
				</div>
			</form>
		</div>
	</body>
</html>