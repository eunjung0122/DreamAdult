<%@page import="test.qna.dao.QnADao"%>
<%@page import="test.qna.dto.QnADto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   int num=Integer.parseInt(request.getParameter("num"));

   String title=request.getParameter("title");
   String category=request.getParameter("category");
   String content=request.getParameter("content");
   System.out.print(content);
   //dto 에 수정반영 된 내용 담기
   QnADto dto=new QnADto();
   dto.setNum(num);
   dto.setTitle(title);
   dto.setCategory(category);
   dto.setContent(content);
   
   boolean isSuccess=QnADao.getInstance().update(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/qna/private/update.jsp</title>
</head>
<body>
<%if(isSuccess){ %>
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
   <script>
   Swal.fire({
		 position: 'top-50 start-50',
		 icon: 'success',
		 text: '정상적으로 글이 수정 되었습니다.',
		 showConfirmButton: false,
		 timer: 1500
	}).then(function(){
		location.href="${pageContext.request.contextPath}/qna/private/detail.jsp?num=<%=dto.getNum()%>";
	});    
   </script>
	   <%}else{ %>
	   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	   <script>
	      Swal.fire({
			  position: 'top-50 start-50',
			  icon: 'error',
			  text: '글이 수정되지 않았습니다.',
			  showConfirmButton: false,
			  timer: 1500
		}).then(function(){
			location.href="${pageContext.request.contextPath}/qna/private/updateform.jsp?num=<%=dto.getNum()%>";
		});	
	   </script>
	   <%} %>
</body>
</html>