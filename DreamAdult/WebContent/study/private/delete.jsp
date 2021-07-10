<%@page import="test.study.dao.StudyCommentDao"%>
<%@page import="test.study.dto.StudyCommentDto"%>
<%@page import="test.study.dao.StudyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));

	//삭제할 글의 작성자와 로그인 된 아이디가 같은지 비교하기
	String writer=StudyDao.getInstance().getData(num).getWriter();
	String id=(String)session.getAttribute("id");
	
	if(!writer.equals(id)){
		response.sendError(HttpServletResponse.SC_FORBIDDEN);
		return;
	}
	
	boolean isSuccess=StudyDao.getInstance().delete(num);
	StudyCommentDao.getInstance().deleteReal(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/study/private/delete.jsp</title>
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
			location.href="${pageContext.request.contextPath }/study/list.jsp";
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
				location.href="${pageContext.request.contextPath}/study/private/detail.jsp?num=<%=num%>";
			});	
	   </script>
	   <%} %>
</body>
</html>