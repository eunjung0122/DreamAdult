<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//int num=Integer.parseInt(request.getParameter("num"));
	int num=Integer.parseInt(request.getParameter("num"));
	//int num2=Integer.parseInt(request.getParameter("num"));
	
	FileDto dto=FileDao.getInstance().getData(num);
	
	//로그인된 아이디 (로그인을 하지 않았으면 null 이다)
	   String id=(String)session.getAttribute("id");
	   // 로그인 여부
	   boolean isLogin=false;
	   if(id!=null){
		   isLogin=true;
	   }
	%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail.jsp</title>
</head>
<body>
	<div class="container">
		<a href="list.jsp">목록보기</a>
		<%if(dto.getWriter().equals(id)){ %>
	        <a href="<%=request.getContextPath() %>/file/private/updateform.jsp?num=<%=dto.getNum()%>">수정</a>
			<a href="<%=request.getContextPath() %>/file/private/delete.jsp?num=<%=dto.getNum()%>">삭제</a> 
		<%} %>
	</div>
	
</body>
</html>