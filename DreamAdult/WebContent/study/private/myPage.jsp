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
<title>/study/private/myPage.jsp</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<style>
   .page-ui a{
      text-decoration: none;
      color: #000;
   }
   
   .page-ui a:hover{
      text-decoration: underline;
   }
   
   .page-ui a.active{
      color: red;
      font-weight: bold;
   }
   .page-ui ul{
      list-style-type: none;
      padding: 0;
   }
   
   .page-ui ul > li{
      float: left;
      padding: 5px;
   }
   

   
</style>
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

	<div class="page-ui clearfix">
      <ul>
         <%if(startPageNum != 1){ %>
            <li>
               <a href="myPage.jsp?pageNum=<%=startPageNum-1 %>">Prev</a>
            </li>   
         <%} %>
         <%for(int i=startPageNum; i<=endPageNum; i++){ %>
            <li>
               <%if(pageNum == i){ %>
                  <a class="active" href="myPage.jsp?pageNum=<%=i %>"><%=i %></a>
               <%}else{ %>
                  <a href="myPage.jsp?pageNum=<%=i %>"><%=i %></a>
               <%} %>
            </li>   
         <%} %>
         <%if(endPageNum < totalPageCount){ %>
            <li>
               <a href="myPage.jsp?pageNum=<%=endPageNum+1 %>" >Next</a>
            </li>
         <%} %>
      </ul>
   </div>  
</div>
</body>
</html>