<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>감사합니다 전체보기</title>
		
		<style>
			/* 큰 틀 */
			#container{ width:1000px;
				 	    height:auto;
				 		margin: 150px auto;
				 		position:relative; }
				 		
			#container p { font-size: 30px;
						   font-weight: bold;}
			
			/* 상단 버튼 */			   
			#btn_div { margin: 20px;
					   text-align:right; }
			
			.myWrite_btn { background:white;
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
						  
			/* 글 */
			#grid_div {
			    display: grid; 
			    grid-template-columns: repeat(3, 1fr); /* 3열 */
			    grid-template-rows: auto; /* 행은 자동으로 추가 */
			    gap: 20px; /* 각 박스 사이 간격 */
			    width: 1000px;
			    height: auto;
			}
			
			#list_div { width:300px;
						height:300px;
						border: 1px solid gray; }
			
			/* 제목 */			
			.title_div { width:250px;
						 height:100px;
						 margin:0 auto; }
						 
			#container .title_div p {
				font-weight:bold;
 				font-size:20px;
 				/* 넘어가는 글 ...처리 */
 			  	overflow:hidden;	
				word-wrap: break-word;
		        display: -webkit-box;
		        -webkit-line-clamp: 2 ; /* 몇 줄까지 보여줄지 */
		        -webkit-box-orient: vertical; }		 
			
			/* 내용 */		 
			.content_div { width: 250px;
						   height:140px;
						   margin:0 auto; }
						   
						    	
			#container .content_div pre { font-size:15px;
										color:#323232;
										overflow:hidden;	
										word-wrap: break-word;
								        display: -webkit-box;
								        -webkit-line-clamp: 3 ;
								        -webkit-box-orient: vertical;}
			
			/* 날짜 이름 */			    
			.date_name_div { width: 250px;
							 height:50px;
							 font-seize:15px;
							 color:gray;
							 margin:0 auto; }
							 
			/* 페이지 */
			#page p { font-size:25px;
					  text-align: center; }
			
			
			/* 팝업 */		
			#list_div:hover { border:3px solid black; }
			
			.modal { position: fixed; /* 화면 고정 */
				     top: 50%;
				     left: 50%;
				     transform: translate(-65%, -45%);
				     display:none;
					 width:800px;
					 background:#f8f8f8;
					 margin: 100px 85px;
					 box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* 그림자 효과 */ }
					 
			.modal .modal_popup #pop_title { font-size: 25px;
											 margin: 10px; }
			
			.modal .modal_popup #pop_content { font-size:16px;
											   /* pre 사용으로 인한 줄바꿈 적용 */
											   white-space: pre-wrap;
  											   word-break: break-all;
  											   overflow: auto;
  											   margin: 30px; }
			
			.modal .modal_popup #pop_date_name { font-size:16px;
												 color: #464646;
												 text-align:right; }
		
			.modal .modal_popup #close_btn { border:1px solid darkgray;
											 width:35px;
											 height:30px;
											 font-size:20px;
											 position:absolute;
											 right:10px;
											 top:10px; }
											 
			#pop_img { width:300px;
					   height:200px;
					   align:center;
					   display:inline;
					   margin: 0 250px; }
			
			/* 팝업 내용 스크롤 */								 
			#pop_content_div { height:400px;
							   overflow-y: scroll; }
		
		</style>
		
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/> 
	
		<div id="container">
			<p>감사합니다</p>
			
			<div id="btn_div">
				<input class="myWrite_btn" type="button" value="내가 작성한 글 보기"
					   onclick="location.href='mypage_managing_posts.do?pat_idx=${param.pat_idx}'"/>
				<input class="insert_btn" type="button" value="감사합니다 글쓰기"
					   onclick="location.href='join_thanks_insert_form.do?pat_idx=${param.pat_idx}'"/>
			</div>
			
			<div id="grid_div">
				<c:forEach var="vo" items="${list}">
					<div id="list_div" class="open_div">
						<div class="title_div">
							<p>${ vo.board_title }</p>
						</div>
						
						<div class="content_div">
							<pre>${ vo.board_content }</pre>
						</div>
						
						<div class="date_name_div">
							 ${fn:split(vo.board_date, ' ')[0]} ${ vo.board_name } 님 
						</div>
						
						<div class="img_div" style="display:none;">
							<img src="${ pageContext.request.contextPath }/resources/uploadThanksCompl/${vo.board_file}">
						</div>
					
					</div>

				</c:forEach>
				
				
				<!-- 상세보기 팝업 -->
				<div class="modal">
					<div class="modal_popup">
						<input type="button" id="close_btn" value="x"/>
						
						<p id="pop_title"></p>
						
						<div id="pop_content_div">
							<pre id="pop_content"></pre>
						</div>
						
						<img id="pop_img">
						
						<p id="pop_date_name"></p>
						
						
					</div>
				</div>

				<!-- 모달 팝업 띄우기 -->
				<script>
				// 모달 관련 요소 선택
				const modal = document.querySelector('.modal');
				const modalClose = document.querySelector('#close_btn');
				const modalTitle = document.querySelector('#pop_title');
				const modalContent = document.querySelector('#pop_content');
				const modalDateName = document.querySelector('#pop_date_name');
				const modalImg = document.querySelector('#pop_img');

				// 리스트 항목에 클릭 이벤트 추가
				document.querySelectorAll('.open_div').forEach(item => {
				    item.addEventListener('click', function() {
				        // 클릭한 항목의 데이터를 가져오기
				        const title = this.querySelector('.title_div p').textContent;
				        const content = this.querySelector('.content_div pre').textContent;
				        const dateName = this.querySelector('.date_name_div').textContent;
				        const imgSrc = this.querySelector('.img_div img').getAttribute('src');

				        // 모달 내용 업데이트
				        modalTitle.textContent = title;
				        modalContent.textContent = content;
				        modalDateName.textContent = dateName;
				        modalImg.setAttribute('src', imgSrc);
				        
				        // 모달 표시
				        modal.style.display = 'block';
				    });
				});

				// 닫기 버튼 클릭 시 모달 닫기
				modalClose.addEventListener('click', function() {
				    modal.style.display = 'none';
				});

				</script>
				
			</div>
			

			
			<div align="center" style="font-size:20px;">
				${ pageMenu }
			</div>
			
		</div>
	</body>
</html>