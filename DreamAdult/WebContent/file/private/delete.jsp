<%@page import="test.file.dao.FileCommentDao"%>
<%@page import="test.file.dao.FileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));

	boolean isSuccess=FileDao.getInstance().delete(num);
	FileCommentDao.getInstance().deleteReal(num);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
</head>
<body>
	<%if(isSuccess){%>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script>
      Swal.fire({
		 position: 'top-50 start-50',
		 icon: 'success',
		 title: '',
		 showConfirmButton: false,
		 timer: 1500
	}).then(function(){
		location.href="${pageContext.request.contextPath }/file/list.jsp";
	}); 
    </script>
	   <%}else{%>
	   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	   <script>
		 Swal.fire({
				position: 'top-50 start-50',
				icon: 'error',
				title: '',
				showConfirmButton: false,
				timer: 1500
		}).then(function(){
				location.href="${pageContext.request.contextPath}/file/private/detail.jsp?num=<%=num%>";
			});
	   </script>
	   <%} %>
</body>
</html>