<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항</title>
		
		<style>
			/* 큰 틀 */
			#container{ width:1000px;
				 	    height:800px;
				 		margin: 150px auto; 
				 		position:relative; }
				 		
			#container p { font-size: 30px;
						   font-weight: bold;}
				 		
			/* select, 검색어, 검색 버튼 묶은 것*/
			#search_div { position:absolute;
						  right:1px;}
						  
			/* 검색 */
			#search { height:30px; }
			
			#search_text { height:25px; }  
			
			#search_btn { height:30px; }
			
			/* 공지사항 */
			#notice_div img { width: 25px;
						 	  height: 25px;}
						 	  
			#notice_div table { border-collapse:collapse;
								width:1000px;
								height:350px;
								position:absolute;
								top: 150px;
								text-align:center;
								table-layout:fixed; }
								
			#notice_div table tr:first-child { border-bottom: 1px solid black; }
			#notice_div table tr:last-child { border-bottom: 1px solid black; }
								
			#notice_div table th { border-top: 2px solid black; }
								   
			#notice_div table td { border-bottom: 1px solid gray; }
				
			/* 제목 a태그 */
			#notice_div a {  text-decoration: none;
								  color:black; }		
								   
			/* 제목 td*/
			#title_td { padding:10px;
						overflow: hidden;
  						text-overflow: ellipsis;
 						white-space: nowrap; }
			
			
			/* 페이지 */
			#page { position:absolute;
					bottom: 10px;
					left:430px;
					font-size:20px; }						   
		</style>
		
		<script>
			window.onload = function(){
				let search = document.getElementById("search");
				let search_text = document.getElementById("search_text");
				
				let search_arr = ['all', 'not_title', 'not_content','title_content'];
				
				for( let i = 0; i < search_arr.length; i++){
					if( '${param.search}' === search_arr[i] ){
						search[i].selected = true;
						search_text.value = '${param.search_text}';
						break;
					}
				}
			} 
		
			//검색
			function search(){
				let search = document.getElementById("search").value;
				
				let search_text = document.getElementById("search_text").value;
				
				if( search != 'all' && search_text === '' ){
					alert("검색할 내용을 입력하세요.");
					return;
				}
				
				location.href="info_notice_list.do?search="+search+
						  "&search_text="+encodeURIComponent(search_text)+
						  "&page=1";
			}
		</script>
	</head>
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="container">
		
			<p>공지사항</p>
		
			<div id="search_div">			
				<select id="search">
					<option value="all">::: 전체보기 :::</option>
					<option value="not_title">제목</option>
					<option value="not_content">내용</option>
					<option value="title_content">제목+내용</option>
				</select>
						
				<input id="search_text">
				<input id="search_btn" type="button" value="검색" onclick="search();">
			</div>
			
			<div id="notice_div">
				<table>
					<colgroup>
						<col width="5%"/>
						<col width="50%"/>
						<col width="25%"/>
						<col width="20%"/>
						<col width="10%"/>
					</colgroup>
				
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>파일</th>
					</tr>
					
					<c:forEach var="vo" items="${list}" varStatus="count">
						<tr>
							<td>${startIndex - count.index}</td>
							<td id="title_td">
								<a href="info_notice_view.do?not_idx=${vo.not_idx}&page=${param.page}">${vo.not_title}</a>
							</td>
							<td>${fn:split(vo.not_date, ' ')[0] }</td>
							<td>${vo.not_hits}</td>
							<td>
								<c:if test="${vo.not_file ne null}">
										<img src="/hos/resources/images/file.png">							
								</c:if>
							</td>
						</tr>
					</c:forEach>
					
				</table>
			</div>
			
			<div id="page">
				${ pageMenu }
			</div>
			
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>