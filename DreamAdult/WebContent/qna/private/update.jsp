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
   <%if(isSuccess){%>
      <script>
         alert("수정 완료 입니다.");
         location.href="${pageContext.request.contextPath}/qna/private/detail.jsp?num=<%=dto.getNum()%>";
      </script>
   <%}else{%>
      <script>
         alert("수정실패 !");
         location.href="${pageContext.request.contextPath}/qna/private/detail.jsp?num=<%=dto.getNum()%>";
      </script>
   <%}%>

</body>
</html>