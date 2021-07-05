<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	FileDao.getInstance().addViewCount(num);
	
	FileDto dto=FileDao.getInstance().getData(num);
	
	
	String id=(String)session.getAttribute("id");
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
		<table>
			<tr>
				<th>글번호</th>
				<td><%=dto.getNum() %></td>
			</tr>
			<tr>
				<th>말머리</th>
				<td><%=dto.getCategory() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=dto.getNick() %> <span><%=dto.getGrade() %></span> </td>
			</tr>
			<tr>
				<th>제목</th>
				<td><%=dto.getTitle() %></td>
			</tr>
			<tr>
				<th>조회수</th>
				<td><%=dto.getViewCount() %></td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<%if(dto.getContent()!=null) {
						dto.getContent();
					} %>
				</td>
			</tr>
				<%if(dto.getOrgFileName()!=null) {%>
					<tr>
						<th>첨부파일</th>
						<td><a href="download.jsp?num=<%=dto.getNum() %>"><%=dto.getOrgFileName() %></a></td>
					</tr>
				<%} %>
		</table>
		<ul>
			<li><a href="<%=request.getContextPath() %>/file/list.jsp">목록보기</a></li>
			<%if(dto.getWriter().equals(id)){ %>
	        	<li><a href="<%=request.getContextPath() %>/file/private/updateform.jsp?num=<%=dto.getNum()%>">수정</a></li>
				<li><a href="<%=request.getContextPath() %>/file/private/delete.jsp?num=<%=dto.getNum()%>">삭제</a></li>
			<%} %>
		</ul>
	</div>
	
</body>
</html>