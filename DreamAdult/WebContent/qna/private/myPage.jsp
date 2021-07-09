<%@page import="test.qna.dto.QnADto"%>
<%@page import="java.util.List"%>
<%@page import="test.qna.dao.QnADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=10;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(strPageNum != null){
	   //숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
	   pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	
	String id=(String)session.getAttribute("id");
	QnADto dto=new QnADto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	dto.setWriter(id);
	List<QnADto> list=QnADao.getInstance().getMyList(dto);
	int totalRow=QnADao.getInstance().getMyCount(dto);
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
		   
	//전체 페이지의 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
	   endPageNum=totalPageCount; //보정해 준다.
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" />
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>
<div class="form-page container">
	<h1 class="main-tit">
	  	<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&amp;opt=C72x72"> 
	   	<span>내가쓴글</span>
   </h1>
	<ul class="tab">
		<li class="tab-list active">
			<a href="${pageContext.request.contextPath}/qna/private/myPage.jsp">글 </a>
		</li>
		<li class="tab-list">
			<a href="${pageContext.request.contextPath}/qna/private/myComment.jsp">댓글</a>
		</li>
	</ul>
	<table class="table">
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
		<%for(QnADto tmp:list){%>
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
            <li>
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