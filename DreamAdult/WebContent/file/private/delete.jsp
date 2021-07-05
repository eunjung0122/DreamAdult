<%@page import="test.file.dao.FileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));

	boolean isSuccess=FileDao.getInstance().delete(num);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
</head>
<body>
	<%if(isSuccess){%>
      <script>
         alert("삭제 했습니다.");
         location.href="<%=request.getContextPath() %>/file/list.jsp";
      </script>
   <%}else{%>
      <script>
         alert("삭제 실패!");
         location.href="<%=request.getContextPath() %>/file/private/detail.jsp?num=<%=num%>";
      </script>
   <%} %>
</body>
</html>