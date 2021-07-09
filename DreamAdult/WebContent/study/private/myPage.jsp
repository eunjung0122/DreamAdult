<%@page import="test.study.dao.StudyDao"%>
<%@page import="test.study.dto.StudyDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=10;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;
	
	int pageNum=1;
	String strPageNum=request.getParameter("pageNum");
	if(strPageNum != null){
	   pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	
	String id=(String)session.getAttribute("id");
	StudyDto dto=new StudyDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	dto.setWriter(id);
	List<StudyDto> list=StudyDao.getInstance().getMyList(dto);
	int totalRow=StudyDao.getInstance().getMyCount(dto);
	
	
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		   
	//전체 페이지의 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	if(endPageNum > totalPageCount){
	   endPageNum=totalPageCount;
	}	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>
<div class="container">
	<h1>내가 쓴 <a href="${pageContext.request.contextPath}/study/private/myPage.jsp">글 </a>/<a href="${pageContext.request.contextPath}/study/private/myComment.jsp">댓글</a></h1>
	<table>
		<thead>
			<th>글번호</th>
			<th>카테고리</th>
			<th>작성자</th>
			<th>제목</th>
			<th>조회수</th>
			<th>등록일</th>
			<th>삭제</th>
		</thead>
		<tbody>
		<%for(StudyDto tmp:list){%>
         <tr>
            <td><%=tmp.getNum() %></td>
            <td><%=tmp.getCategory() %></td>
            <td><%=tmp.getNick() %></td>
            <td>
               <a href="detail.jsp?num=<%=tmp.getNum()%>"><%=tmp.getTitle() %></a>
            </td>
            <td><%=tmp.getViewCount() %></td>
            <td><%=tmp.getRegdate() %></td>
            <td>
            	<a href="delete.jsp?num=<%=tmp.getNum()%>">삭제</a>
            </td>
         </tr>
      <%} %>
		</tbody>
	</table>

	<nav class="pagination-wrap">
      <ul class="pagination">
         <%if(startPageNum != 1){ %>
            <li class="page-item">
               <a class="page-link" href="myPage.jsp?pageNum=<%=startPageNum-1 %>">Prev</a>
            </li>   
         <%} %>
         <%for(int i=startPageNum; i<=endPageNum; i++){ %>
             <%if(pageNum == i){ %>
             <li class="page-item active">
                <a class="page-link" href="myPage.jsp?pageNum=<%=i %>"><%=i %></a>
             </li>   
             <%}else{ %>
             <li class="page-item">
                <a class="page-link" href="myPage.jsp?pageNum=<%=i %>"><%=i %></a>
             </li>   
             <%} %>
         <%} %>
         <%if(endPageNum < totalPageCount){ %>
            <li class="page-item">
               <a class="page-link" href="myPage.jsp?pageNum=<%=endPageNum+1 %>" >Next</a>
            </li>
         <%} %>
      </ul>
   </nav>  
</div>
</body>
</html>