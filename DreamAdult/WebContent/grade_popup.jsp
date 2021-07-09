<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	String grade=UsersDao.getInstance().getGrade(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>grade_popup.jsp</title>
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

	img {
		width: 200px;
		height: 200px;
	}
	strong {
		color: #0d6efd;
	}
</style>
</head>
<body>
<h1 class="modal-title text-center mt-3">
	<strong><%=id %></strong>님의 등급 업그레이드!
</h1>
<div class="modal-body text-center">
	<p>
		<img src="images/grade_img1.gif"/>
		<br />
		<strong><%=grade %></strong> 등급이 되신걸 환영합니다! 
	</p>
</div>
<form class="text-center" action="nopopup.jsp" method="post">
	<button type="submit" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
</form>
</body>
</html>