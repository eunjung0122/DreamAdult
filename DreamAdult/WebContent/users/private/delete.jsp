<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. session 영역에서 로그인된 아이디를 읽어온다.
	String id=(String)session.getAttribute("id");
	//2. 해당 아이디를 DB 에서 삭제 한다.
	UsersDao.getInstance().delete(id);
	//3. 로그 아웃 처리를 한다.
	session.removeAttribute("id");
	//4. 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
</head>
<body>
<div class="container">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
	Swal.fire({
		 position: 'top-50 start-50',
		 icon: 'success',
		 title: '회원탈퇴가 완료 되었습니다.',
		 text: '그동안 DreamAdult 를 이용해 주셔서 감사합니다.',
		 showConfirmButton: false,
		 timer: 2100
	}).then(function(){
		location.href="${pageContext.request.contextPath}/index.jsp";
	});
</script>
</div>
</body>
</html>




