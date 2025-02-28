<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		
		<style>
			a{text-decoration:none;
			color: black;
			font-weight: bold;
			font-size: 16px;
			margin-right: 40px;
			margin-left: 40px;
			cursor: pointer;
			}
			
			a:hover{ color:red; }
			
			hr{width: 380px;}
		</style>
		
		<script src="/hos/resources/js/httpRequest.js"></script>
		<script>
			function del(banner_idx, banner_file) {
				if(!confirm("해당 배너를 삭제하시겠습니까?")){
					return;
				}
				
				let url = "delete_banner.do";
				let param = "banner_idx=" + banner_idx + "&banner_file=" + banner_file;
				
				sendRequest(url, param, delFn, "get");
			}
			
			function delFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					let json = (new Function('return ' + data))();
					
					if(json[0].result == "fail"){
						alert("삭제 실패");
						return;
					}else{
						alert("삭제 성공");
						
						//팝업창 닫기(새로고침 후 배너 적용됨)
						window.close();
					}//inner
					
				}//outer
			}
			
		</script>
		
	</head>
	<body>
		<center>
			<h2>삭제할 배너를 선택해 주세요</h2>
			<hr>
			<c:forEach var="vo" items="${banner}">
				<img src="/hos/resources/images/${vo.banner_file}" width="100px">
				<a onclick="del(${vo.banner_idx}, '${vo.banner_file}');">${vo.banner_name}</a><br>
			</c:forEach>
		</center>
	</body>
</html>


