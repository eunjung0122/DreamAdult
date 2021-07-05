<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/popup.jsp</title>
<style>
	img {
		width: 200px;
		height: 200px;
	}
</style>
</head>
<body>
<h1>코린이 여러분, 환영합니다.</h1>
<p>
	<img src="images/developer2.jpeg"/>
	<br />
	개발공부를 함께 공유하며, 멋진 코른이가 되어봅시다!
	<a href="users/signup_form.jsp">회원가입</a>
</p>
<form action="nopopup.jsp" method="post">
	<label>
		<input type="checkbox" name="isPopup" value="no" />
		1분동안 팝업 띄우지 않기
	</label>
	<button type="submit">닫기</button>
</form>
</body>
</html>