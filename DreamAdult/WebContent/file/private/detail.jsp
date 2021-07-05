<%@page import="java.util.List"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	FileDao.getInstance().addViewCount(num);
	   
	String category=request.getParameter("category");
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	if(keyword==null){
		keyword="";
		condition="";
	}
	if(category==null){
		category="whole";
	}
		
	String encodedK=URLEncoder.encode(keyword);
		
	FileDto dto=new FileDto();
	dto.setNum(num);
		
	if(category.equals("whole")&&!keyword.equals("")){
		if(condition.equals("title")){
			dto.setTitle(keyword);
			dto=FileDao.getInstance().getDataT(dto);
		}else if(condition.equals("nick")){
			dto.setNick(keyword);
			dto=FileDao.getInstance().getDataN(dto);
		}else if(condition.equals("title_content")){
			dto.setTitle(keyword);
			dto.setContent(keyword);
			dto=FileDao.getInstance().getDataTC(dto);
			}
	}else if(category.equals("whole")&&keyword.equals("")){
			dto=FileDao.getInstance().getData(dto);
	}else if(keyword.equals("")&&!category.equals("whole")){
			dto.setCategory(category);
			dto=FileDao.getInstance().getDataC(dto);
	}else if(!category.equals("whole")&&!keyword.equals("")){
		if(condition.equals("title")){
			dto.setCategory(category);
			dto.setTitle(keyword);
			dto=FileDao.getInstance().getDataTCa(dto);
		}else if(condition.equals("nick")){
			dto.setCategory(category);
			dto.setNick(keyword);
			dto=FileDao.getInstance().getDataNCa(dto);
		}else if(condition.equals("title_content")){
			dto.setCategory(category);
			dto.setTitle(keyword);
			dto.setContent(keyword);
			dto=FileDao.getInstance().getDataTCCa(dto);
		}
	}
	
	
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
		<%if(dto.getPrevNum()!=0){ %>
    		<a href="detail.jsp?num=<%=dto.getPrevNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">이전글</a>
   		<%} %>
   		<%if(dto.getNextNum()!=0){ %>
      		<a href="detail.jsp?num=<%=dto.getNextNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>">다음글</a>
   		<%} %>
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