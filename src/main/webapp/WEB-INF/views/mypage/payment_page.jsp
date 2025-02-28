<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>온라인 진료비 결제</title>
		
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
			
			/* a태그 - "온라인 진료비 결제" */
			#payment_text{
				display: block;
				font-size: 40px;
				margin-bottom: 30px;
			}
			
			/* 시작일, 종료일 */
			#date_div{	
				position: relative;
			}
			#date_div input[type="date"]{
				height: 20px;
			}
			
			#start_text{
				position: absolute;
			}
			#end_text{
				position: absolute;
				left: 150px;
			}
			#start_day{
				position: absolute;
				top: 40px;
				width: 140px;
				padding: 5px 0px;
			}
			#end_day{
				position: absolute;
				left: 150px;			
				top: 40px;
				width: 140px;
				padding: 5px 0px;
			}
			/* input[type="button"] - 조회버튼 */
			#date_btn{
				position: absolute;
				left: 300px;
				top: 40px;
				width: 50px;
				padding: 6px 0px;
				border: none;
				color: white;
				background-color: #D2D2D2;
			}
			/* 전체조회버튼 */
			#all_btn{
				position: absolute;
				left: 355px;
				top: 40px;
				width: 85px;
				padding: 6px 0px;
				border: none;
				color: white;
				background-color: #D2D2D2;
			}
			
			/* 진료일, 진료과, 진료비 테이블 */			
			#main_div table{
				width: 1000px;
				margin-top: 20px;
				border-collapse:collapse;
			}
			/* th태그 */
			#main_div table th{
				font-size: 18px;
				font-weight: bold;
				background-color: #12B8BA;
				color: white;
				padding: 10px;
				border: 3px solid white;
			}
			#th_none{
				background-color: white;
			}
			/* td태그 */
			#main_div table td{
				font-size: 17px;
				height: 50px;
				padding-left: 10px;
			}

			#main_div table td input[type="checkbox"]{
    			margin: auto;
				zoom: 1.3;
			}
			
			/* input[type="button"] - 결제진행버튼 */
			#payment_btn{
				margin: 10px 0px;
				width: 1000px;
				height: 50px;		
				border: none;
				background-color: #12B8BA;	
				color: white;
			}
			
		</style>
		
		<script>
			//조회버튼 클릭
			function set_period() {
			    let start_day = document.getElementById("start_day").value;
			    let end_day = document.getElementById("end_day").value;

			    if (!start_day || !end_day) {
			        alert("시작일과 종료일을 모두 입력해주세요.");
			        return;
			    }

			    if (start_day > end_day) {
			        alert("종료일은 시작일 이후여야 합니다.");
			        return;
			    }

			    let rows = document.querySelectorAll("#payment_list tr");
			    rows.forEach(row => {
			        let res_time = row.querySelector("td:nth-child(2)")?.innerText.trim() || "";
			        let res_date = res_time.split(" ")[0];

			        if (res_date >= start_day && res_date <= end_day) {
			            row.style.display = "";
			        } else {
			            row.style.display = "none";
			        }
			    });
			}
			
			//전체조회버튼 클릭
			function all_period() {
			    document.getElementById("start_day").value = "";
			    document.getElementById("end_day").value = "";
			
			    let rows = document.querySelectorAll("#payment_list tr");
			    rows.forEach(row => {
			        row.style.display = ""; // 모든 행을 보이도록 설정
			    });
			}
						
			let total = 0;
			function calc_total(checkbox) {
			    let value = parseInt(checkbox.value, 10);
	
			    if (checkbox.checked) {
			        total += value;
			    } else {
			        total -= value;
			    }
	
			    const paymentBtn = document.getElementById("payment_btn");
			    paymentBtn.value = total + "원 결제진행";
			}
			
			//결제버튼 클릭
			function payment_btn() {
				//결제 예정금액 = total
			}
		</script>
	</head>
	<body>
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<div id="main_div">
			<div>
				<a id="payment_text">온라인 진료비 결제</a>
				
				<div id="date_div">
					<a id="start_text">시작일</a>
					<a id="end_text">종료일</a>
	
					<br>
					<form>
						<input id="start_day" type="date">
						<input id="end_day" type="date">
						<input id="date_btn" type="button" value="조회" onclick="set_period(this.form);">
						<input id="all_btn" type="button" value="전체조회" onclick="all_period(this.form);">
					</form>
				</div>
				
				<br>
				<table>
					<tr id="result_div">
						<th id="th_none"></th>
						<th><a class="category">진료일</a></th>
						<th><a class="category">진료과(담당교수)</a></th>
						<th><a class="category">진료비</a></th>
					</tr>
					
					<!-- 지불해야 할 진료비 리스트 -->
					<tbody id="payment_list">
					<c:forEach var="vo" items="${ list }">
						<tr>
							<th style="background-color: white;">
								<input type="checkbox" id="1" value="${ vo.dept_payment }" onchange="calc_total(this);">
							</th>
							<td>${ vo.res_time }</td>
							<td><a>${ vo.dept_name } (${ vo.pro_name })</a></td>
							<td><a>${ vo.dept_payment }원</a>
								<span style="display:none;">${vo.dept_payment}</span>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				
				<input id="payment_btn" type="button" value="0원 결제진행" onclick="payment_btn();">
			</div>
		
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
	</body>
</html>