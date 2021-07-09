<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/popup.jsp</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Nerko+One&family=Noto+Sans:wght@700&display=swap"
	rel="stylesheet">
<style>
	body {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 16px;
	}	

	.title-font{
		font-family:'Montserrat', 'Noto Sans KR', sans-serif;
		font-size: 18px;
		font-weight: 700;
	}
	img {
		width: 200px;
		height: 200px;
	}
	a{
		color:#000;
		text-decoration: none;
	}
	a:hover{
		color:#000;
		text-decoration: none;
	}
	strong {
		color: #0d6efd;
	}
	.btn-secondary {
		margin-left:10px;
	}
</style>
<link rel="stylesheet" href="contextPath" />
</head>
<body>
 
<h1 class="modal-title text-center mt-3">코린이 여러분, 환영합니다.</h1>

<div class="modal-body text-center">
	<p>
		<img src="images/popup_img.gif"/>
		<br />
		개발공부를 함께 공유하며, 멋진 <strong>코른이</strong>가 되어봅시다!
	</p>
</div>
<form class="text-center" action="nopopup.jsp" method="post">
	<label>
		<input type="checkbox" name="isPopup" value="no" />
		하루동안 팝업 띄우지 않기
	</label>
	
	<button type="submit" class="btn btn-s btn-custom-dark" data-bs-dismiss="modal">닫기</button>
	<button type="button" class="btn btn-s btn-custom-yellow"><a href="users/signup_form.jsp">회원가입</a></button>
</form>

</body>
</html>