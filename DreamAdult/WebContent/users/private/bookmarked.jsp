<%@page import="test.study.dao.StudyBookMarkDao"%>
<%@page import="test.study.dto.StudyBookMarkDto"%>
<%@page import="test.file.dao.FileBookMarkDao"%>
<%@page import="test.file.dto.FileBookMarkDto"%>
<%@page import="test.qna.dto.QnADto"%>
<%@page import="java.util.List"%>
<%@page import="test.qna.dao.QnABookMarkDao"%>
<%@page import="test.qna.dto.QnABookMarkDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%   
   //QnA
   String id=(String)session.getAttribute("id");

   QnABookMarkDto dto=new QnABookMarkDto();
   dto.setId(id);
   List<QnABookMarkDto> list=QnABookMarkDao.getInstance().getMyList(dto);
   
   //File
   FileBookMarkDto dtoF=new FileBookMarkDto();
   dtoF.setId(id);
   List<FileBookMarkDto> listF=FileBookMarkDao.getInstance().getMyList(dtoF);
   
   //Study
   StudyBookMarkDto dtoS=new StudyBookMarkDto();
   dtoS.setId(id);
   List<StudyBookMarkDto> listS=StudyBookMarkDao.getInstance().getMyList(dtoS);
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
<div class="sub_page container">
   	<h1 class="main_tit">
		<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&opt=C72x72"/>
		<span style="display:inline-block; font-size: 2.0rem;">개념쌓기</span>
	</h1>
   <table class="table table-hover">
     <colgroup>
	    <col width="100px"/>
	    <col width="200px"/>
	    <col width="auto" style="text-align:left;"/>
	    <col width="160px"/>
	    <col width="200px"/>
	    <col width="80px"/>
	 </colgroup>
      <thead>
         <th>No</th>
         <th>카테고리</th>
         <th>제목</th>
         <th>작성자</th>
         <th>등록일</th>
         <th>조회수</th>         
         <th>Unmark</th>
      </thead>
      <tbody>
      <%for(StudyBookMarkDto tmp:listS){ %>
      <tr>
         <td><%=tmp.getNum() %></td>
         <td><%=tmp.getCategory() %></td>
         <td>
         <a href="<%=request.getContextPath()%>/study/private/detail.jsp?num=<%=tmp.getNum() %>"><%=tmp.getTitle() %></a>
         </td>
         <td><%=tmp.getNick() %></td>         
         <td><%=tmp.getRegdate() %></td>
         <td><%=tmp.getViewCount() %></td>
         <td>
         <a href="<%=request.getContextPath()%>/study/private/study_redirect.jsp?num=<%=tmp.getNum()%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bookmark-check-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5zm8.854-9.646a.5.5 0 0 0-.708-.708L7.5 7.793 6.354 6.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z"/></a>
         </td>
      </tr>
      <%} %>
      </tbody>
   </table>

   <h1 class="main_tit">
		<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72">
		<span style="display:inline-block; font-size: 2.0rem;">코드드림</span>
	</h1>
   <table class="table table-hover">
     <colgroup>
	    <col width="100px"/>
	    <col width="200px"/>
	    <col width="auto" style="text-align:left;"/>
	    <col width="160px"/>
	    <col width="200px"/>
	    <col width="80px"/>
	 </colgroup>
      <thead>
         <th>No</th>
         <th>카테고리</th>
         <th>제목</th>
         <th>작성자</th>
         <th>등록일</th>
         <th>조회수</th>
         <th>Unmark</th>
      </thead>
      <tbody>
      <%for(FileBookMarkDto tmp:listF){ %>
      <tr>
         <td><%=tmp.getNum() %></td>
         <td><%=tmp.getCategory() %></td>
         <td>
         <a href="<%=request.getContextPath()%>/file/private/detail.jsp?num=<%=tmp.getNum() %>"><%=tmp.getTitle() %></a>
         </td>
         <td><%=tmp.getNick() %></td>
         <td><%=tmp.getRegdate() %></td>
         <td><%=tmp.getViewCount() %></td>         
         <td>
         <a href="<%=request.getContextPath()%>/file/private/file_redirect.jsp?num=<%=tmp.getNum()%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bookmark-check-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5zm8.854-9.646a.5.5 0 0 0-.708-.708L7.5 7.793 6.354 6.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z"/></a>
         </td>
      </tr>
      <%} %>
      </tbody>
   </table>
   
   <h1 class="main_tit">
		<img style="width:72px; height:72px;" src="https://www.kakaocorp.com/page/ico_customer.png"/>
		<span style="display:inline-block; font-size: 2.0rem;">묻고답하기</span>
   </h1>
   <table class="table table-hover">
     <colgroup>
	    <col width="100px"/>
	    <col width="200px"/>
	    <col width="auto" style="text-align:left;"/>
	    <col width="160px"/>
	    <col width="200px"/>
	    <col width="80px"/>
	 </colgroup>
      <thead>
         <th>No</th>
         <th>카테고리</th>
         <th>제목</th>
         <th>작성자</th>
         <th>등록일</th>
         <th>조회수</th>         
         <th>Unmark</th>
      </thead>
      <tbody>
      <%for(QnABookMarkDto tmp:list){ %>
      <tr>
         <td><%=tmp.getNum() %></td>
         <td><%=tmp.getCategory() %></td>
         <td>
         <a href="<%=request.getContextPath()%>/qna/private/detail.jsp?num=<%=tmp.getNum() %>"><%=tmp.getTitle() %></a>
         </td>
         <td><%=tmp.getNick() %></td>
         <td><%=tmp.getRegdate() %></td>
         <td><%=tmp.getViewCount() %></td>
         <td>
         <a href="<%=request.getContextPath()%>/qna/private/qna_redirect.jsp?num=<%=tmp.getNum()%>"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bookmark-check-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5zm8.854-9.646a.5.5 0 0 0-.708-.708L7.5 7.793 6.354 6.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z"/></a>
         </td>
      </tr>
      <%} %>
      </tbody>
   </table>
</div>
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>