<%@page import="test.qna.dao.QnACommentDao"%>
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
	QnACommentDao.getInstance().deleteReal(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/qna/private/delete.jsp</title>
</head>
<body>
   <%if(isSuccess){%>
      <script>
         alert("삭제 했습니다.");
         location.href="${pageContext.request.contextPath }/qna/list.jsp";
      </script>
   <%}else{%>
      <script>
         alert("삭제 실패!");
         location.href="detail.jsp?num=<%=num%>";
      </script>
   <%} %>
</body>
</html>