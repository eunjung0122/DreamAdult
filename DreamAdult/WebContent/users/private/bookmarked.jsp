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
<title>/users/private/bookmarked</title>
</head>
<body>
<div class="container">
	<h2>QnA 북마크 된 글</h2>
	<table>
		<thead>
			<th>글번호</th>
			<th>카테고리</th>
			<th>작성자</th>
			<th>제목</th>
			<th>조회수</th>
			<th>등록일</th>
			<th>북마크 해제</th>
		</thead>
		<tbody>
		<%for(QnABookMarkDto tmp:list){ %>
		<tr>
			<td><%=tmp.getNum() %></td>
			<td><%=tmp.getCategory() %></td>
			<td><%=tmp.getNick() %></td>
			<td>
			<a href="<%=request.getContextPath()%>/qna/private/detail.jsp?num=<%=tmp.getNum() %>"><%=tmp.getTitle() %></a>
			</td>
			<td><%=tmp.getViewCount() %></td>
			<td><%=tmp.getRegdate() %></td>
			<td>
			<a href="<%=request.getContextPath()%>/qna/private/qna_redirect.jsp?num=<%=tmp.getNum()%>">해제</a>
			</td>
		</tr>
		<%} %>
		</tbody>
	</table>
	<h2>자료실 북마크 된 글</h2>
	<table>
		<thead>
			<th>글번호</th>
			<th>카테고리</th>
			<th>작성자</th>
			<th>제목</th>
			<th>조회수</th>
			<th>등록일</th>
			<th>북마크 해제</th>
		</thead>
		<tbody>
		<%for(FileBookMarkDto tmp:listF){ %>
		<tr>
			<td><%=tmp.getNum() %></td>
			<td><%=tmp.getCategory() %></td>
			<td><%=tmp.getNick() %></td>
			<td>
			<a href="<%=request.getContextPath()%>/file/private/detail.jsp?num=<%=tmp.getNum() %>"><%=tmp.getTitle() %></a>
			</td>
			<td><%=tmp.getViewCount() %></td>
			<td><%=tmp.getRegdate() %></td>
			<td>
			<a href="<%=request.getContextPath()%>/file/private/file_redirect.jsp?num=<%=tmp.getNum()%>">해제</a>
			</td>
		</tr>
		<%} %>
		</tbody>
	</table>
	<h2>학습게시판 북마크 된 글</h2>
	<table>
		<thead>
			<th>글번호</th>
			<th>카테고리</th>
			<th>작성자</th>
			<th>제목</th>
			<th>조회수</th>
			<th>등록일</th>
			<th>북마크 해제</th>
		</thead>
		<tbody>
		<%for(StudyBookMarkDto tmp:listS){ %>
		<tr>
			<td><%=tmp.getNum() %></td>
			<td><%=tmp.getCategory() %></td>
			<td><%=tmp.getNick() %></td>
			<td>
			<a href="<%=request.getContextPath()%>/study/private/detail.jsp?num=<%=tmp.getNum() %>"><%=tmp.getTitle() %></a>
			</td>
			<td><%=tmp.getViewCount() %></td>
			<td><%=tmp.getRegdate() %></td>
			<td>
			<a href="<%=request.getContextPath()%>/study/private/study_redirect.jsp?num=<%=tmp.getNum()%>">해제</a>
			</td>
		</tr>
		<%} %>
		</tbody>
	</table>
</div>
</body>
</html>