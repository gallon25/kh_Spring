<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의료기기 정보</title>
<style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .info-box {
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
	<h1>의료기기 상세 정보</h1>
    <div class="info-box">
        <p><strong>의료기기 이름:</strong> ${device.dev_name}</p>
        <p><strong>의료기기 설명:</strong> ${device.dev_content}</p>
    </div>
</body>
</html>