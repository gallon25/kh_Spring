<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>층별안내</title>
		
		<style>
			/* 큰 틀 */
			#container{ width:1000px;
				 	    height:800px;
				 		margin: 150px auto; 
				 		position:relative; }
			
			/* 검색, 층별 테이블 묶음 */
			#floor_div { position:absolute;
						 left: 30px;
						 top: 200px; }
						 	 
				 
			/* 검색 돋보기 사진 */
			#search img { width: 30px;
						  height: 30px; 
						  margin: 0 auto;}
			/* 검색 text */			  
			#search_text { width: 210px;
						   height: 30px; }
			
			
			/* 층수 테이블 */	 
			#floor_table th { width: 40px;
							  height: 40px;}
			
			/* 층별 장소 테이블 */			  
			#floor_table td { width: 200px;
							  height: 320x;}
							  
			#floor_table li { list-style: none;
							  font-size: 13px; }
			
			/* 세로선 */
			#line { border-left: 1px solid lightgray;
					height: 750px;
					position:absolute;
					left: 300px;
					top: 25px; }				  
			
			/* 상단 카테고리 글씨 */				  
			#top_text { font-size: 30px;
					   	position:absolute;
					   	left: 320px;
					   	top: 50px; }
			
			
			/* 지도 사진 */
			#map_img img { width: 650px;
					   	   height: 550px;
					   	   position: absolute;
					   	   right: 30px;
					   	   top: 150px; } 	
							  
						
		</style>
		
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
	
		<div id="container">
			<div id="floor_div">
				<table id="search">
					<tr>
						<td><input id="search_text" placeholder="찾는 곳을 입력하세요"></td>
						<td><img src="/hos/resources/images/search.png"></td>
					</tr>
				</table>
				
				
				<table border="1" id="floor_table">
					<tr>
						<th>6F</th>
						<td rowspan="8">
							<ul>
								<li>내과</li>
								<li>뇌신경센터</li>
								<li>당뇨검사실</li>
								<li>당뇨교육실</li>
								<li>방사선검사실</li>
								<li>석고실</li>
							</ul>
						</td>
					</tr>
					
					<tr>
						<th><a href="#">5F</a></th>
					</tr>
					
					<tr>
						<th>4F</th>
					</tr>
					
					<tr>
						<th>3F</th>
					</tr>
					
					<tr>
						<th>2F</th>
					</tr>
					
					<tr>
						<th>1F</th>
					</tr>
					
					<tr>
						<th>B1</th>
					</tr>
					
					<tr>
						<th>B2</th>
					</tr>
					
					
				</table>
			</div>
			
			<div id="line"></div>
			
			<div id="top_text">
				<p>층별안내</p>
			</div>
			
			<div id="map_img">
				<img src="/hos/resources/images/floor_map.PNG">
			</div>
			
		</div>
	</body>
</html>