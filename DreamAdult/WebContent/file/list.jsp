<%@page import="test.file.dto.FileDto"%>
<%@page import="java.util.List"%>
<%@page import="test.file.dao.FileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<FileDto> list=FileDao.getInstance().getList();	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
</head>
<body>
	<div>
		<a href="insertform.jsp">새글 작성</a>
		<table>
	         <thead>
	            <tr>
	               <th>글번호</th>
	               <th>카테고리</th>
	               <th>제목</th>
	               <th>작성자</th>
	               <th>조회수</th>
	               <th>등록일</th>
	            </tr>
	         </thead>
	         <tbody>
	            <%for(FileDto tmp:list){%>
	                  <tr>
	                     <td><%=tmp.getNum() %></td>
	                     <td><%=tmp.getCategory() %></td>
	                     <td><a href="detail.jsp"><%=tmp.getTitle() %></a></td>
	                     <td><%=tmp.getNick() %></td>
	                     <td><%=tmp.getViewCount() %></td>
	                     <td><%=tmp.getRegdate() %></td>
	                  </tr>
	               <%} %>
	         </tbody>
	      </table>	
	</div>
</body>
</html>