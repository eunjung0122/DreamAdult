<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String id=(String)session.getAttribute("id");%>
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
		<li><a href="qna/list.jsp">Q&A</a></li>
		<li><a href="file/list.jsp">자료실</a></li>
		<li><a href="study/list.jsp">학습공부</a></li>
	</ul>
</div>

<%
	Cookie[] cookies=request.getCookies();
	
	boolean isPopup=true;
	if(cookies != null){
		for(Cookie tmp : cookies){
			if(tmp.getName().equals("isPopup")){
				isPopup=false;
			}
		}
	}
%>

<%if(isPopup){ %>
	<script>
		window.open("popup.jsp", "웰컴팝업창", "width=500,height=400,top=100,left=100");
	</script>
<%} %>
</body>
</html>