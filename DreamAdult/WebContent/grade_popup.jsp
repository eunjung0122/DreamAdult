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
<style>
	img {
		width: 300px;
		height: 200px;
	}
</style>
</head>
<body>
<h1><%=id %> 회원님의 등급 업그레이드!</h1>
<p>
	<img src="images/pngwing.com.png"/>
	<br />
	<%=grade %> 등급이 되신걸 환영합니다~! 
	<br />
	앞으로도 잘 부탁드립니다! 
</p>
<form action="nopopup.jsp" method="post">
	<label>
		<input type="checkbox" name="gradePopup" value="no" />
		확인
	</label>
	<button type="submit">닫기</button>
</form>
</body>
</html>