<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String id=(String)session.getAttribute("id"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
</head>
<body>
<div class="container">
	<h1>Dream Adult</h1>
	<%if(id!=null){ %> 
		<p>
			<a href="users/private/info.jsp"><%=id %></a>	님 로그인 중..
			<a href="users/logout.jsp">로그아웃</a>	  
		</p>
	<%} %>
	<ul>
		<li><a href="users/loginform.jsp">로그인</a></li>
		<li><a href="users/signup_form.jsp">회원가입</a></li>
	</ul>
</div>
</body>
</html>