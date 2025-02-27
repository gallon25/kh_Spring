<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>

<html>
	<head>
		<meta charset="UTF-8">
		<title>자원봉사 상세보기</title>
		
		<style>
			#main_div{
				width: 1000px;
				margin: 0px auto;
			}
			
			#title{
				font-weight:bold;
				font-size:30px;
				text-align: center;
				margin: 20px;
			}
			
			#period{
				font-size:20px;
				text-align: center;
				margin: 20px;
			}
			
			#hit_and_regdate{
				text-align: center;
				margin: 20px;
			}
			
			#contents pre{
				font-size:15px;
				white-space: pre-wrap;
				word-break: break-all;
				overflow: auto;
				margin: 30px;}
			
			/* 파일첨부 div */
			#file{
				width: 1000px;
				height: 50px;
				margin: 20px auto;
				background-color: lightgray;
			}
			#file p{
				font-weight:bold;
				font-size: 20px;
				color: #3232FF;
			}
			
			/* 댓글입력 div */
			#comment_input_div{
				position: relative;
				height: 150px;
			}
			#comment_input_div img{
				width: 40px;
				height: 40px;
				margin: 0px;
			}
			#comment_input_div p{
				position: absolute;
				left: 60px;
				top: 15px;
			}
			#comment_input_div textarea{
				position: absolute;
				left: 5px;
				width: 900px;
				resize:none;
				border: none;
				margin: 10px 30px;	
			}
			
			.comm_insert_btn{
				width:50px;
				height:30px;
				position:absolute;
				bottom:30px;
				right:5px;
				}
			
			/* 댓글조회 div */
			.comment_list{
				position: relative;
				height: 150px;
			}
			.comment_list img{
				width: 40px;
				height: 40px;
				margin: 0px;
			}
			.comment_list p{
				position: absolute;
				left: 60px;
				top: 15px;
			}
			.comment_list pre{
				margin: 5px;
			}
			.comment_list hr{
				margin-top: 20px;
			}
			
			/* 이전글, 다음글 */
			#pre_next_div { margin:20px 0; }
			
			#pre_next_div table { border-collapse:collapse;
								  width:1000px;
								  height:100px; }
			
			#pre_next_div table tr { border-top:1px solid gray;
									 border-bottom:1px solid gray; }
									 
			#pre_next_div table a { text-decoration:none;
									color:black; }
				
			/* 목록으로 버튼 */	
			#back_btn {
				background: #3086C9;
				border:none;
				color:white;
				height:50px;
				width: 70px;
				font-size:15px;
				margin: 50px auto;}
				
			/* 페이지 */
			#page { position:absolute;
					bottom: 10px;
					left:430px;
					font-size:20px; }
		</style>
		
		<script src="/hos/resources/js/httpRequest.js"></script>
		
		<script>
			let comm_page = 1;
		
			window.onload = function(){
				comment_list(comm_page);
			}
		
			//댓글 추가
			function comment_insert(f){
				let comm_content = f.comm_content.value;
				
				if( comm_content === '' ){
					alert('댓글 작성을 위해 내용을 입력해주세요.');
					return;
				}
				
				let url = "join_volcomment_insert.do";
				let param = "pat_idx="+encodeURIComponent(f.pat_idx.value)+
							"&vol_idx="+encodeURIComponent(f.vol_idx.value)+
							"&comm_name="+encodeURIComponent(f.comm_name.value)+
							"&comm_content="+encodeURIComponent(comm_content);
				
				sendRequest( url, param, insert_result, "get" );
			}
			
			function insert_result(){
				if(xhr.readyState == 4 && xhr.status == 200 ){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if( json[0].result == "succ" ){
						comment_list(comm_page);
						
					}else{
						alert("댓글 등록에 실패하였습니다.");
					}
				}
			} 
			
			//댓글 조회
			function comment_list( page ){
				
				comm_page = page;
				
				let url = "join_volcomm_list.do";
				let param = "pat_idx=${param.pat_idx}"+
							"&vol_idx=${param.vol_idx}"+
							"&comm_page="+comm_page;
				
				sendRequest( url, param, list_result, "get");
				
			}
			
			function list_result(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let disp = document.getElementById("comment_list_div");
					disp.innerHTML = data;
				}
			}
			
			//댓글 삭제
			function comm_del(f){
				let comm_idx = f.comm_idx.value;
				
				if( !confirm("정말 댓글을 삭제하시겠습니까?") ){
					return;
				}
				
				let url = "join_volcomm_del.do";
				let param = "comm_idx="+comm_idx;
				sendRequest(url, param, comm_del_result, "get");
			}
			
			function comm_del_result(){
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if( json[0].result === "succ" ){
						comment_list( comm_page );
					}else{
						alert("삭제를 실패하였습니다.");
					}
				}
			}
		</script>
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="main_div">
			<hr>
			<div id="title">
				<p>${vo.vol_title}</p>
			</div>
	
			<div id="period">
				<p>${fn:split(vo.vol_start_date, ' ')[0]} ~ ${fn:split(vo.vol_end_date, ' ')[0]}</p>
			</div>
			
			<div id="hit_and_regdate">
				<p>조회수 : ${vo.vol_hits} | 등록일 : ${fn:split(vo.vol_date, ' ')[0]}</p>
			</div>
			<hr>
			
			<div id="contents">
				<pre>${vo.vol_content}</pre>
			</div>
			
			<!-- 첨부파일 div -->
			<div id="file">
				<p>파일첨부</p>
				<a href="/hos/resources/uploadVolFile/${vo.vol_file}" target="_blank">${vo.vol_file}</a>
			</div>
			
			<!------------------------------------------------------------------->
			
			<!-- 댓글입력 div -->
			<div id="comment_input_div">
				<form>
					<input type="hidden" name="pat_idx" value="${param.pat_idx}"/>
					<input type="hidden" name="vol_idx" value="${param.vol_idx}"/>
					<input type="hidden" name="comm_name" value="${patVO.pat_name}"/>
					
					<img id="profile" src="/hos/resources/images/profile.png">
					<p>${patVO.pat_name}</p><br>
					<textarea rows="5" name="comm_content" placeholder="댓글을 입력하세요"></textarea>
				
					<input class="comm_insert_btn" type="button" value="등록"
						   onclick="comment_insert(this.form);"/>
				</form>
			</div>
			
			<hr>
			
			<!-- 댓글조회 div -->
			<div id="comment_list_div">
			</div>
			
			<div id="page">
				${ pageMenu }
			</div>
			
			<!-- 이전글, 다음글 -->
			<div id="pre_next_div">
				<table>
					<tr>
						<th>이전글</th>
						<td>
							<c:if test="${preVol ne null}">
								<a href="join_volunteer_view.do?pat_idx=${param.pat_idx}&vol_idx=${preVol.vol_idx}&page=${param.page}">${preVol.vol_title}</a>						
							</c:if>
							
							<c:if test="${preVol eq null }">
								이전 글이 존재하지 않습니다.
							</c:if>
						</td>
					</tr>
					
					<tr>
						<th>다음글</th>
						<td>
							<c:if test="${nextVol ne null}">
								<a href="join_volunteer_view.do?pat_idx=${param.pat_idx}&vol_idx=${nextVol.vol_idx}&page=${param.page}">${nextVol.vol_title}</a>							
							</c:if>
							
							<c:if test="${nextVol eq null}">
								다음 글이 존재하지 않습니다.
							</c:if>
						</td>
					</tr>
				</table>
			</div>
			
			<div>			
				<input type="button" id="back_btn" value="목록으로"
					   onclick="location.href='join_volunteer_list.do?pat_idx=${param.pat_idx}&page=${param.page}'">
			</div>
			
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>