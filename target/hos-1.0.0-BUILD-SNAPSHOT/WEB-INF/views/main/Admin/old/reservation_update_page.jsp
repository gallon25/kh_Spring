<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		  
		<script src="/hos/resources/js/httpRequest.js"></script>
		<script src="/hos/resources/js/reservation_manage_update.js?v=1.0"></script>
		<link rel="stylesheet" href="/hos/resources/css/reservation_manage_update.css?v=1.0">
		
		<script>
		//시간 셋팅, 예약과 결제 체크박스 미리 체크
		window.onload = function () {
		    let select = document.getElementById("time_schedule");
		    let startTime = 9; // 시작 시간
		    let endTime = 19;  // 종료 시간

		    // 시간 옵션 추가
		    for (let hour = startTime; hour < endTime; hour++) {
		        for (let min = 0; min < 60; min += 30) {
		            let hourStr = hour.toString().padStart(2, '0');
		            let minStr = min.toString().padStart(2, '0');

		            // 시간 문자열 생성
		            let timeContent = hourStr + ":" + minStr;

		            // <option> 태그 생성
		            let option = document.createElement("option");
		            option.value = timeContent;
		            option.innerHTML = timeContent;

		            // <select> 태그에 추가
		            select.appendChild(option);
		        }
		    }
		    
		 	// 서버에서 전달된 예약,결제여부값 (0 또는 1)
			let resChkValue = ${res_vo.res_chk}; 
			let payChkValue = ${res_vo.pay_chk};

		    // 값에 따라 예약 체크박스를 체크
		    if (resChkValue === 1) {
		        document.getElementById('chk_res_1').checked = true;
		    } else if (resChkValue === 0) {
		        document.getElementById('chk_res_0').checked = true;
		    }
		    
		    // 값에 따라 결제 체크박스를 체크
		    if (payChkValue === 1) {
		        document.getElementById('chk_pay_1').checked = true;
		    } else if (payChkValue === 0) {
		        document.getElementById('chk_pay_0').checked = true;
		    }
		};
		//======================================================================================
		//예약 수정
	    function reservation_update(f) {
		    let dateValue = f.dateValue.value; 
		    let timeValue = f.timeValue.value; 
		    
			if(timeValue == ""){
				alert("예약시간을 선택해주세요");
				return;
			}
			
		    // 날짜와 시간 결합(DB에 넣을 수 있는 DATE형태로 만들어주기)
		    let DateTime = dateValue + " " + timeValue;
		
		    // 숨겨진 필드에 DateTime 추가
		    let hiddenField = document.createElement("input");
		    hiddenField.type = "hidden";
		    hiddenField.name = "res_time"; // 필요한 파라미터 이름
		    hiddenField.value = DateTime;
		    f.appendChild(hiddenField);
			
		    // 불필요한 필드 이름 제거
		    f.dateValue.name = ""; // URL에 포함되지 않도록 name 제거
		    f.timeValue.name = ""; // URL에 포함되지 않도록 name 제거
		
		    // GET 요청으로 전송
		    f.method = "GET";
		    f.action = "reservation_update.do?pro_idx=" + f.pro_idx.value;
		    f.submit();
		}
		</script> 
		 
	</head>
	<body>
	    <form>
	    	<!-- form으로 보낼 실제 데이터값 -->
			<input type="hidden" value="${res_vo.pro_idx}" id="professorIdx" name="pro_idx">
			
			<table border="1" id="reservation_update_table">
				<tr>
					<th>예약번호</th>
					<td>
						<input class="update_td" value="${res_vo.res_idx}" readonly="readonly" name="res_idx">
					</td>
				</tr>
				<tr>
					<th>환자이름</th>
					<td>
						<input class="update_td" value="${param.pat_name}" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>교수이름</th>
					<td>
						<input class="update_td" value="${param.pro_name}(${param.dept_name})" 
							readonly="readonly" id="professorName">
						<input type="button" value="교수목록" onclick="professor_list();" 
							class="btn_style_2">
					</td>
				</tr>
				<tr>
					<th>예약시간</th>
					<td>
						<input type="date" id="update_td_resTime" class="update_td" value="${res_vo.res_time}"
							style="width: 40.5%;" name="dateValue">
						<select id="time_schedule" class="update_td" style="width: 40.5%;" name="timeValue">
							<option value="">시간선택</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>예약여부</th>
					<td>
						예약확인&ensp;
						<input type="checkbox" value="1" class="cb_res" name="res_chk" id="chk_res_1"
						       onclick="cb_check_res(this);">&emsp;
						예약취소(현장취소)&ensp;
						<input type="checkbox" value="0" class="cb_res" name="res_chk" id="chk_res_0"
						       onclick="cb_check_res(this);">
					</td>
				</tr>
				<tr>
					<th>결제여부</th>
					<td>
						결제확인&ensp;
						<input type="checkbox" value="1" class="cb_pay" name="pay_chk" id="chk_pay_1"
							onclick="cb_check_pay(this);">&emsp;
						결제미확인&ensp;
						<input type="checkbox" value="0" class="cb_pay" name="pay_chk"  id="chk_pay_0"
							onclick="cb_check_pay(this);">
					</td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<input type="button" value="수정하기" onclick="reservation_update(this.form);"
							class="btn_style_1">
						<input type="button" value="돌아가기" onclick="history.back();"
							class="btn_style_2">
					</td>
				</tr>
			</table>
		</form>
		
		<!-- 교수 목록 팝업 -->
	    <div id="professorListContainer">
	        <h3 style="text-align: center;">교수 목록</h3>
	        <hr style="margin-top: 10px; border: 1px solid black">
	        <div id="professorList">
	            <!-- 동적으로 데이터가 추가 -->
	        </div>
	    </div>
    	
	</body>
</html>

