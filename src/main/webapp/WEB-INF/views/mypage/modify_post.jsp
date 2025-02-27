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
                  	 margin: 0px auto; }
                   
         #container p { font-size: 30px;
                     	font-weight: bold;}
         
         /* 테이블 */            
         #container table { border-collapse: collapse;
                        	align:center;
                        	width:1000px; }
                        
         #container table th { width: 250px;
							   height: 50px;
							   color:#323232; }
                          
         #container table p { color:#3232FF;
                         	  font-size:13px; }
                         
         #container table tr:first-child { border-top: 1px solid black; }             

         #container table tr:last-child { border-bottom: 1px solid black; }             
         
         #container table tr { border: 1px solid gray; }
         
         #container table tr th, td { padding: 10px;}
            
         /* 입력창 */                
         .name_txt { width: 180px;
                  	 height: 30px;
                  	 outline:none; }
                  
         .pat_phone_s { width: 90px; 
                  	 	height: 34px; }
         
         .pat_phone { width: 90px;
                  	 height: 30px;
                  	 outline:none; }
                   
         .title_txt { width: 500px;
                  	 height: 30px;
                  	 outline:none; }
         
         .content_txt { resize:none;
                  	 	width:600px;
                     	height:600px; }
                     
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
                       color:white; }
         
                   
      </style>
   </head>
   
   
   <body>
      <div id="container">
         <p>나의 게시글 수정</p>
         <form method="post"
              enctype="multipart/form-data">
            <table>
               <tr>
                  <th>작성자 성함</th>
                  <td>
                     <input class="name_txt"/>
                  </td>
               </tr>
               
               <tr>
                  <th>휴대폰번호</th>
                  <td> 
                           <select class="pat_phone_s" name="pat_phone1_1">
                              <option value="010">010</option>
                              <option value="011">011</option>
                              <option value="016">016</option>
                              <option value="017">017</option>
                              <option value="018">018</option>
                              <option value="019">019</option>
                           </select> - 
                           <input class="pat_phone" name="pat_phone1_2"> -
      
                           <input class="pat_phone" name="pat_phone1_3">
                           <p class="text">연락가능한 전화번호를 입력 해 주시기 바랍니다.</p>
                        </td>
               </tr>
               
               <tr>
                  <th>제목</th>
                  <td>
                     <input class="title_txt"/>
                  </td>
               </tr>
               
               <tr>
                  <th>내용</th>
                  <td>
                     <textarea class="content_txt" placeholder="한글 4000자 입력 가능합니다."></textarea>
                  </td>
               </tr>
            </table>
            
            <div id="btn_div">
               <input class="list_btn" type="button" value="감사합니다 전체보기"/>
               <input class="insert_btn" type="button" value="확인"/>
            </div>
         </form>
      </div>
   </body>
</html>