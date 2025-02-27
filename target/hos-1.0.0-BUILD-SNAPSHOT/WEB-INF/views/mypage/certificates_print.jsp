<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>증명서 발급</title>
		
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
			}

			#cert_text{
				display: block;
				margin-bottom: 30px;
				font-size: 40px;
				font-weight: 500;
			}
			
			/* 발급받을 증명서 목록 */
			#cert_select {
			    font-size: 18px;
			    margin: 0px auto;
			    padding: 10px;
			    width: 1000px;
			    background-color: #12B8BA;
			    color: white;
			    border: none;
			    appearance: none; /* 기본 브라우저 스타일 제거 */
			}
			
			#cert_select option {
			    font-size: 18px;
			    padding-top: 10px; /* padding 적용 */
			    padding-bottom: 10px; /* padding 적용 */
			}
			
			.title{
				font-size: 24px;
				margin: 15px 0px;
			}
			
			/* cert_info 태그들 */
			#main_div table{	
				border-collapse: collapse;
				width: 1000px;
			}
			#main_div table td{
				padding: 10px;
			}
			#table_header th{
				height: 40px;
			}

			/* 증명서 별로 달라지는 div구간 */
			.cert_section{
				height: 500px;
			}
			
			#main_div hr{
				width: 1000px;
				margin: 10px 0px;
			}
			
			/* td - 환자정보 */
			.pat_info, .period{
				font-size: 18px;
			}
			/* td - 기간선택 */
			.period{
				width: 70px;	
			}
			
			/* input[type="date"] = 기간선택 */
			input[type="date"] {
				padding-left: 10px;
				height: 40px;
				width: 180px;
			}
			
			/* 증명서 발급받기 버튼 */
			#main_div input[type="button"]{
				display: block;
				margin: 10px auto;
				font-size: 18px;
				width: 200px;
				height: 40px;
				background-color: #12B8BA;		
				color: white;
				border: none;	
			}
		</style>
		
		<script>
			function show_div() {
				let cert_select = document.getElementById("cert_select");
				let selected_item = cert_select.value;
				
				//모든 div 숨기기
				let all_section = document.querySelectorAll('.cert_section');
				let info_section = document.querySelectorAll('.cert_info_section');
				all_section.forEach(section => section.style.display = 'none');
				info_section.forEach(section => section.style.display = 'none');
				
				//선택된 div만 보이기
				selected_section = document.getElementById(selected_item)
				selected_section.style.display = 'block';
			}
		</script>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<div id="main_div">
			<a id="cert_text">증명서 발급</a>
			
			<select id="cert_select" onchange="show_div();">
				<option value="cert_info">진단서 발급 안내</option>
				<option value="cert_confirm">진료 사실 확인서</option>
				<option value="cert_payment">진료비 납입 확인서</option>
				<option value="cert_receipt">진료비 계산서, 영수증</option>
				<option value="cert_prescription">처방전 사본</option>
				<option value="cert_diagnosis">진단서 사본</option>
			</select>
			
			<!-- 진단서 발급 안내 =========================================================-->
			<div id="cert_info" class="cert_info_section">
				<p class="title">진단서, 소견서 및 입원사실 증명서 발급 절차 안내</p>
				<hr>
				
				<p>외래환자인 경우</p>
				<a>1. 외래진료를 예약하여 진료 시 담당 의사에게 진단서 발급을 요청합니다.</a><br>
				<a>2. 진료 후 수납 시 진단서를 발급받습니다.</a>
				
				<p>입원환자인 경우</p>
				<a>1. 담당 주치의에게 진단서 발급을 요청합니다.</a><br>
				<a>2. 진단서를 받아 원무과에서 직인을 받습니다.</a>
				
				<p class="title">그 외 제증명 발급안내</p>
				<hr>
				<table border="1">
					<colgroup>
						<col width="25%"/>
						<col width="25%"/>
						<col width="50%"/>
					</colgroup>
					
					<tr id="table_header">
						<th>제증명 종류</th>
						<th>확인 사항</th>
						<th>발급 방법</th>
					</tr>
					
					<tr>
						<th>진료 사실 확인서</th>
						<td>통원 일자만 기재되어 있음</td>
						<td rowspan="2">
							병원방문 :<br>
							무인발급기에서 발급<br>
							<br>
							무인발급기 위치 : <br>
							- 본원 1층 공용 원무창구 앞<br>
							- 본원 1층 류마티스내과·정형외과 원무창구 옆<br>
							- 본원 2층 공용 원무창구 앞<br>
							- 본원 3층 산부인과 원무창구 앞<br>
							- 대한외래 지하 2층 공용 원무창구 앞<br>
							- 대한외래 지하 3층 공용 원무창구 앞<br>
							<br>
							인터넷 :<br>
							- 증명서발급홈페이지에서 로그인 후 발급<br>
						</td>
					</tr>
					
					<tr>
						<th>진료비 납입 확인서</th>
						<td>연말정산 겸용</td>
					</tr>
					
					<tr>
						<th>진료비 계산서, 영수증<br>
							재발급 및 상세(세부)내역서
						</th>
						<td></td>
						<td>
							외래 진료비 계산서·영수증 재발급 및 상세(세부) 내역서 :<br>
							- 대한외래 지하 2층 : <br>
							제증명 창구, 원무 접수·수납 창구(공용 수납 창구), 신장·비뇨의학센터 수납 창구, 정신건강의학센터 수납 창구<br>
							- 대한외래 지하 3층 : <br>
							원무 접수·수납 창구(공용 수납 창구)<br>
							- 본원 지하 1층 뇌신경센터 수납 창구<br>
							- 본원 1층 내과계 수납 창구<br>
							- 본원 1층 외과계 수납 창구<br>
							- 본원 1층 제증명 창구<br>
							- 본원 2층 국제 수납 창구(국제진료센터 내 위치)<br>
							- 어린이병원별관 지하2층 가정의학과 수납 창구<br>
							<br>
							입·퇴원 진료비 계산서·영수증 재발급 : <br>
							- 본원 2층 원무1과(입원원무) 사무실 <br>
							- 본원 2층 입퇴원수속창구 앞 키오스크 <br>
							<br>
							진료비 상세(세부) 내역서 재발급 <br>
							- 본원 2층 원무1과(입원원무) 사무실 <br>
						</td>
					</tr>
				</table>
			</div> <!-- cert_info -->
			
			<!-- 진료 사실 확인서 =========================================================-->
			<div id="cert_confirm" class="cert_section" style="display:none">
				<p class="title">진료 사실 확인서</p>
				<hr>
				
				<table>
				    <tr>
				        <td colspan="2" class="pat_info">
				            ${ patient.pat_name }님 ( ${ patient.pat_idx } / ${ patient.pat_id } )
				        </td>
				    </tr>
				    
				    <tr>
				        <td class="period">
				            기간선택
				        </td>    
				        <td>
				            <input class="start_date" type="date">
				            <a class="date_text">~</a>
				            <input class="end_date" type="date">
				        </td>
				    </tr>
				</table>
				<hr>
				
				<input type="button" value="증명서 발급받기" onclick="location.href='mypage_cert_confirm.do?file_type=cert_confirm'">
			</div>
			
			<!-- 진료비 납입 확인서 =========================================================-->
			<div id="cert_payment" class="cert_section" style="display:none">
				<p class="title">진료비 납입 확인서</p>
				<hr>
				
				<table>
				    <tr>
				        <td class="pat_info">
				            ${ patient.pat_name }님 ( ${ patient.pat_idx } / ${ patient.pat_id } )
				        </td>
				    </tr>
				</table>
				<hr>
				
				<input type="button" value="증명서 발급받기" onclick="location.href='mypage_cert_confirm.do?file_type=cert_payment'">
			</div>
			
			<!-- 진료비 계산서, 영수증 =========================================================-->
			<div id="cert_receipt" class="cert_section" style="display:none">
				<p class="title">진료비 계산서, 영수증</p>
				<hr>
				
				
				<table>
				    <tr>
				        <td colspan="2" class="pat_info">
				            ${ patient.pat_name }님 ( ${ patient.pat_idx } / ${ patient.pat_id } )
				        </td>
				    </tr>
				    
				    <tr>
				        <td class="period">
				            기간선택
				        </td>    
				        <td>
				            <input class="start_date" type="date">
				            <a class="date_text">~</a>
				            <input class="end_date" type="date">
				        </td>
				    </tr>
				</table>
				<hr>
				
				<input type="button" value="증명서 발급받기" onclick="location.href='mypage_cert_confirm.do?file_type=cert_receipt'">
			</div>

			<!-- 처방전 사본 =========================================================-->
			<div id="cert_prescription" class="cert_section" style="display:none">
				<p class="title">처방전 사본</p>
				<hr>
				
				
				<table>
				    <tr>
				        <td colspan="2" class="pat_info">
				            ${ patient.pat_name }님 ( ${ patient.pat_idx } / ${ patient.pat_id } )
				        </td>
				    </tr>
				    
				    <tr>
				        <td class="period">
				            기간선택
				        </td>    
				        <td>
				            <input class="start_date" type="date">
				            <a class="date_text">~</a>
				            <input class="end_date" type="date">
				        </td>
				    </tr>
				</table>
				<hr>
				
				<input type="button" value="증명서 발급받기" onclick="location.href='mypage_cert_confirm.do?file_type=cert_prescription'">
			</div>
			
			<!-- 진단서 사본 =========================================================-->
			<div id="cert_diagnosis" class="cert_section" style="display:none">
				<p class="title">진단서 사본</p>
				<hr>
				
				<table>
				    <tr>
				        <td colspan="2" class="pat_info">
				            ${ patient.pat_name }님 ( ${ patient.pat_idx } / ${ patient.pat_id } )
				        </td>
				    </tr>
				    
				    <tr>
				        <td class="period">
				            기간선택
				        </td>    
				        <td>
				            <input class="start_date" type="date">
				            <a class="date_text">~</a>
				            <input class="end_date" type="date">
				        </td>
				    </tr>
				</table>
				<hr>
				
				<input type="button" value="증명서 발급받기" onclick="location.href='mypage_cert_confirm.do?file_type=cert_diagnosis'">
			</div>
			
		</div><!-- main_div -->
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>