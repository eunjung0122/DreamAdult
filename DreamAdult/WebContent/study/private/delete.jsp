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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/study/private/delete.jsp</title>
</head>
<body>
   <%if(isSuccess){%>
      <script>
         alert("삭제 했습니다.");
         location.href="${pageContext.request.contextPath }/study/list.jsp";
      </script>
   <%}else{%>
      <script>
         alert("삭제 실패!");
         location.href="detail.jsp?num=<%=num%>";
      </script>
   <%} %>
</body>
</html>