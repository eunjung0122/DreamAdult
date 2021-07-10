<%@page import="test.qna.dao.QnADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));

	//삭제할 글의 작성자와 로그인 된 아이디가 같은지 비교하기
	String writer=QnADao.getInstance().getData(num).getWriter();
	String id=(String)session.getAttribute("id");
	
	if(!writer.equals(id)){
		response.sendError(HttpServletResponse.SC_FORBIDDEN);
		return;
	}
	
	boolean isSuccess=QnADao.getInstance().delete(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/qna/private/delete.jsp</title>
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
		location.href="${pageContext.request.contextPath }/qna/list.jsp";
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
			location.href="${pageContext.request.contextPath}/qna/private/detail.jsp?num=<%=num%>";
		});	
	   </script>
	   <%} %>
</body>
</html>