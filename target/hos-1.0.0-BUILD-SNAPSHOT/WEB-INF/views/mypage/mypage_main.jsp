<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>   
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>마이페이지</title>
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
            	display: flex;
            	justify-content: space-between;
            	flex-wrap: wrap;
            	width: 1000px;
            	margin: 20px auto;
            }
            
            #main_div hr{
            	background: black;
            	height: 1px;
            	border: none;
            	margin-top: 10px;
            }
			
			/* p태그 - 마이페이지 */
			#mypage_title{
				display: block;
				width: 1000px;
				font-size: 40px;
				font-weight: 500;
				margin-bottom: 20px;
			}
			
            /* ================================================= */
            /* 환자정보 div */
            #patient_info_div {
                width: 455px;
 				height: 220px;
                padding: 20px;
                border: 1px solid #D8D8D8; /* 테두리 */
                border-top: 2px solid #12B8BA; /* 테두리 */
                text-align: left;
                display: inline-block;
            }
            /* p태그 - ~님(환자번호)*/
            #welcome_text {
                display: inline;
                margin-right: 5px;
                font-size: 24px;
            }

			/* table 태그 - 환자정보테이블 */
            #patient_table {
                border-spacing: 0 15px; /* 행 간 간격 15px*/
            }
            #patient_table th{
            	width: 60px;
            	border-right: 2px solid black;
            }
            
            /* 회원정보 수정, 회원탈퇴 버튼 */
            #container1_btn1, #container1_btn2{
            	width: 220px;
            	padding: 5px 0px;
            	border: none;
            	color: white;
            	background-color: #12B8BA;
			    transition: all 0.2s ease;
            }
            #container1_btn1{
            	margin-right: 9px;
            }
			
			/* ================================================= */
            /* 예약내역 div */
            #res_info_div {
                width: 455px;
 				height: 220px;
                padding: 20px;
                border: 1px solid #D8D8D8; /* 테두리 */
                border-top: 2px solid #12B8BA; /* 테두리 */
                text-align: left;
                display: inline-block;
                position: relative;
                
            }
            #res_info_div  a{
            	font-size: 24px;
            }
            
            #res_info_div input[type='button']{
            	width: 25px;
            	height: 25px;
            	border: none;
            	background-color: #12B8BA;
            	color: white;
            	text-align: center;
            	
            	position: absolute;
            	right: 20px;
            	top: 20px;
            }
            #res_ul_div ul{
	 		  	margin-left:20px;
                font-size: 18px;
            }
            #res_ul_div ul li{
            	margin-top: 7px !important;
            }
            #res_ul_div ul li:first-child{
            	margin-top: 0px !important;
            }
            
            /* 스크롤바 추가 */
            #res_ul_div {
            	overflow-y: scroll; 
            	height: 150px;
            }
            /* 스크롤바 css */
			#res_ul_div::-webkit-scrollbar {
				margin-top: 16px;
			    width: 5px;
			}
			#res_ul_div::-webkit-scrollbar-track { 
			    background-color: white;
			}
			#res_ul_div::-webkit-scrollbar-thumb { 
			    background-color: #12B8BA;
			}
			#res_ul_div::-webkit-scrollbar-button {
			    display: none;
			}
			
			/* hover 효과 */
			#res_ul_div::-webkit-scrollbar-thumb:hover {
			    background-color: #0F9C9B;
			    transition: all 0.2s; /* 작동 안 됨 */
			}
			
			/* 코너에 라운드 효과 */
			#res_ul_div::-webkit-scrollbar-track,
			#res_ul_div::-webkit-scrollbar-thumb {
			    border-radius: 5px;
			}
	
            /* ================================================= */
            /* 증명서 발급안내 div */
            .container_cert{
				width: 288px;
 				height: 220px;
                padding: 20px;
                border: 1px solid #D8D8D8; /* 테두리 */
                border-top: 2px solid #12B8BA; /* 테두리 */
                display: inline-block;
                position: relative;
			}
			/* a태그 - 증명서발급안내 */
			#cert_text{
				text-decoration: none;
				font-size: 24px;
				color: black;
			}
			/* ul태그 - 증명서발급안내 */
            .container_ul {
                margin-top: 10px;
                margin-left: 20px;
                font-size: 18px;
            }
            .container_ul li{
            	margin-top: 5px;
            }
            /* 증명서 발급 버튼 */
            .container2_buttons{
            	width: 290px;
            	padding: 5px 10px;
            	border: none;
            	color: white;
            	background-color: #12B8BA;
			    transition: all 0.2s ease;
			    position: absolute;
			    bottom: 20px;
            }
                        
            /* ================================================= */
            /* container2 클래스 객체들(진료비결제, 작성글관리 버튼) */
            #etc_div {
            	display: flex;
			    justify-content: space-between;
			    gap: 5px; /* 요소 간 간격 추가 */
			    flex-wrap: wrap;
            }
            #etc_div div{
                width: 288px;
 				height: 220px;
                padding: 20px;
                border: 1px solid #D8D8D8;
                border-top: 2px solid #12B8BA;
                display: inline-block;
                position: relative;
            }
            
            .container2 input[type='button']{
             	width: 290px;
            	padding: 5px 10px;
            	border: none;
            	color: white;
            	background-color: #12B8BA;
			    transition: all 0.2s ease;
			    position: absolute;
			    bottom: 20px;
             }
             
             .container2 a{
             	font-size: 24px;
             }
             
             .container2 p{
             	margin-top: 10px;
             	line-height: 1.5;
             }
             
            /* 예약내역, 진료비결제, 작성글관리 버튼 */
			.container3_image{
				width: 150px;
			}
        </style>
    	
    	<script>
    		function withdrawal() {
				if(confirm("탈퇴하시겠습니까?")){
					if(confirm("· 회원 탈퇴 시 KH대학병원 홈페이지에서 온라인 서비스를 이용하실 수 없습니다.\n"
							+ "· 회원 탈퇴 시 회원님의 회원정보가 모두 삭제되며 복구할 수 없습니다.")){
						location.href='mypage_withdrawal.do?pat_idx=' + ${param.pat_idx};
					}
				}
			}
    	</script>
    </head>
    <body>
    	<!-- 메뉴바 -->
		<jsp:include page="/WEB-INF/views/main/MenuBar_User.jsp"/>
		
		<div id="main_div">
		
			<p id="mypage_title">마이페이지</p><br>
			
			<!-- 회원정보 및 회원정보수정칸 -->
	        <div id="patient_info_div">
	        
	            <a id="welcome_text">${sessionScope.patient.pat_name}</a><span>( 환자번호 : ${sessionScope.patient.pat_idx} )</span>
	            <hr>
	            <table id="patient_table">
	                <tr>
	                    <th>연락처</th>
	                    <td>&emsp;${sessionScope.patient.pat_phone}</td>
	                </tr>
	                <tr>
	                    <th>이메일</th>
	                    <td>&emsp;${sessionScope.patient.pat_email}</td>
	                </tr>
	                <tr>
	                    <th>주소</th>
	                    <td>&emsp;${sessionScope.patient.pat_address_road},<br>
	                        &emsp;${sessionScope.patient.pat_address_detail}</td>
	                </tr>
	            </table>

	            <input type="button" id="container1_btn1" value="회원정보 수정"
	             onclick="location.href='mypage_update_form.do?pat_idx=${sessionScope.patient.pat_idx}'">
	            <input type="button" id="container1_btn2" value="회원 탈퇴"
	             onclick="withdrawal();">
	        </div>
	        
	        <!-- 예약내역 -->
        	<div id="res_info_div" >
        		<a>예약내역조회</a><input type="button"value="+" onclick="location.href='mypage_reservation_list.do?pat_idx=${sessionScope.patient.pat_idx}'">
        		<hr>
        		<div id="res_ul_div">
	        		<ul>
	        		<c:forEach var="res" items="${ list }">
						<li>${ res.res_time } | ${ res.dept_name } (${ res.pro_name } 교수)</li>
	        		</c:forEach>
	        		</ul>
        		</div>
        	</div>
	        
	        <!-- 증명서 발급, 진료비결제, 작성글관리 등 -->
			<div id="etc_div">
			    <div class="container_cert" id="cert_div">
			        <a id="cert_text">증명서 발급 안내</a>
			        <hr>
			        <ul class="container_ul">
			            <li>진료 사실 확인서</li>
			            <li>진료비 납입 확인서</li>
			            <li>진료비 계산서, 영수증</li>
			            <li>처방전 사본</li>
			            <li>진단서 사본</li>
			        </ul>
			        <input type="button" class="container2_buttons" value="증명서 발급" 
			         onclick="location.href='mypage_certificates_print.do?pat_idx=${sessionScope.patient.pat_idx}'">
			    </div>
			    
			    <div class="container2">
					<a>온라인 진료비 결제</a>
					<hr>
					<p>수납창구 방문 없이<br> 온라인으로 진료비를 결제할 수 있습니다.</p>
			        <input type="button" class="container3_a" value="진료비결제" onclick="location.href='mypage_payment_page.do?pat_idx=${sessionScope.patient.pat_idx}'">
			    </div>
			    
			    <div class="container2">
					<a>나의 작성글 관리</a>
					<hr>
					<p>게시판에 작성한 글을<br> 수정, 삭제할 수 있습니다.</p>
			        <input type="button" class="container3_a" value="작성글관리" onclick="location.href='mypage_managing_posts.do?pat_idx=${sessionScope.patient.pat_idx}'">
			    </div>
			</div>
	        
		</div>
		
		<jsp:include page="/WEB-INF/views/main/Footer.jsp"/>
    </body>
</html>




