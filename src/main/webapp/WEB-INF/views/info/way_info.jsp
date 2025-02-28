<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	    <title>오시는길</title>
	    	    
	  	<style>
	  		/* 큰 틀 */
			#container{ width:1000px;
				 		margin: 150px auto; 
				 		position:relative; }
				 		
			#container p { font-size: 30px;
						   font-weight: bold;}	
			
			/* 상단 큰 지도 */
			#hos_map img { width: 1000px;
						   height: 400px; }	
						   
						    
			/* 지하철 안내 */
			#subway {position:relative; }
			
			#subway p { font-size: 25px; }
			
			#subway table { border-collapse:collapse;}		   
			
			#subway table th { background:#F0F8FF;
							   width: 300px;
							   height: 80px; }	
							   
			#subway table td { width: 700px;
							   text-align:center; }
			
			/* 버스 안내 */
			#bus table { border-collapse:collapse; }
			
			#bus p { font-size: 25px; }
					 
			#bus table th { background:#F0F8FF;
							   width: 300px;
							   height: 80px; }	
							   
			#bus table td { width: 700px;
							   text-align:center; }
							   
			/* 고속도로 안내 */
			#car table { border-collapse:collapse; }
			
			#car p { font-size: 25px; }
					 
			#car table th { background:#F0F8FF;
							   width: 300px;
							   height: 80px; }	
							   
			#car table td { width: 700px;
							   text-align:center; }
			
			
	  	</style>  
	    
	</head>
	
	
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<div id="container">
			<p>오시는길</p>
			
			<div id="hos_map">
				<img src="/hos/resources/images/hos_map.PNG">
			</div>
			
			<div id="subway">
				<p>지하철</p>
				<table border="1">
					<tr>
						<th>혜화(서울대학교병원)역</th>
						<td>4호선 혜화(서울대학교병원)역 3번 출구 (암병원까지 도보 8분거리)</td>
					</tr>
				</table>
			</div>
			
			<div id="bus">
				<p>버스</p>
				<table border="1">
					<tr>
						<th rowspan="2">혜화역, 서울대학교병원입구<br>3번 출구 앞 하행</th>
						<td>간선 : 109, 273, 601, N16</td>
					</tr>
					
					<tr>
						<td>지선 : 2112</td>
					</tr>
					
					<tr>
						<th rowspan="2">혜화역,<br>마로니에 공원 앞 상행</th>
						<td> 간선 : 100, 102, 104, 106, 107, 108, 109, 140, 143, 150,
							<br>160, 162, 273, 301, 710, N16</td>
					</tr>
					
					<tr>
						<td>지선 : 2112</td>
					</tr>
					
					<tr>
						<th>창경궁 입수 상행</th>
						<td>간선 : 151, 171, 172, 272, 601</td>
					</tr>
					
					<tr>
						<th rowspan="2">창경궁 서울대학교병원 하행</th>
						<td>100, 102, 104, 107, 108, 140, 143, 150, 151,
							<br>160, 162, 171, 172, 301, 710</td>
					</tr>
					
					<tr>
						<td>6011</td>
					</tr>
					
					<tr>
						<th>창경궁, 고궁호텔,<br>메이플레이스호텔 정류장</th>
						<td>2112, 종로07, 종로08[01585]</td>
					</tr>
				</table>
			</div>
			
			<div id="car">
				<p>고속도로</p>
				<table border="1">
					<tr>
						<th>네비게이션 주소</th>
						<td>서울시 종로구 대학로 101(서울시 종로구 연견동 28)</td>
					</tr>
					
					<tr>
						<th>경부선</th>
						<td>서울요금소 → 한남대교 → 을지로 → 이화사거리 → 대학로 → 서울대학교병원</td>
					</tr>
					
				</table>
			</div>
			
			
		</div>
	</body>
</html>