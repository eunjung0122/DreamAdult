<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.study.dao.StudyDao"%>
<%@page import="test.study.dto.StudyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   //로그인 된 아이디를 session 영역에서 얻어내기
   String writer=(String)session.getAttribute("id");

   //닉네임 정보를 얻어오기 위한 작업
   String id=(String)session.getAttribute("id");
   String nick=UsersDao.getInstance().getData(id).getNick();

   //폼 전송되는 제목, 말머리, 내용 읽어오기
   String title=request.getParameter("title");
   String category=request.getParameter("category");
   String content=request.getParameter("content");

   //db에 저장하기
   StudyDto dto=new StudyDto();
   dto.setWriter(writer);
   dto.setNick(nick);
   dto.setTitle(title);
   dto.setCategory(category);
   dto.setContent(content);
   
   boolean isSuccess=StudyDao.getInstance().insert(dto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
</head>
<body>
   <%if(isSuccess){ %>
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
   <script>
   Swal.fire({
		 position: 'top-50 start-50',
		 icon: 'success',
		 text: '정상적으로 글이 등록 되었습니다.',
		 showConfirmButton: false,
		 timer: 1500
	}).then(function(){
		location.href="${pageContext.request.contextPath}/study/list.jsp";
	});    
   </script>
	   <%}else{ %>
	   <script>
		   Swal.fire({
				  position: 'top-50 start-50',
				  icon: 'error',
				  text: '글이 등록되지 않았습니다.',
				  showConfirmButton: false,
				  timer: 1500
			}).then(function(){
				location.href="${pageContext.request.contextPath}/study/private/insertform.jsp";
			});	
	   </script>
	   <%} %>
</body>
</html>