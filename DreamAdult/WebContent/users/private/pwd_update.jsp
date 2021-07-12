<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// session 영역에서 로그인된 아이디 얻어내기
	String id=(String)session.getAttribute("id");
	// 폼전송되는 구 비밀번호, 새 비밀번호 읽어오기
	String pwd=request.getParameter("pwd");
	String newPwd=request.getParameter("newPwd");
	// 구 비밀번호가 유효한 정보인지 알아낸다. 
	UsersDto dto=UsersDao.getInstance().getData(id);
	boolean isValid = pwd.equals(dto.getPwd());
	// 구 비밀번호가 맞다면 비밀번호를 수정한다.
	if(isValid){
		//dto 에 새 비밀번호를 담아서 
		dto.setPwd(newPwd);
		//dao 에 넘겨줘서 수정 반영한다. 
		UsersDao.getInstance().updatePwd(dto);
		//비밀번호를 수정했으면 로그 아웃처리를 하고 새로 로그인 하도록 한다.
		session.removeAttribute("id");
	}
	// 응답한다.
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_update.jsp</title>
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>
<div class="container">
	<%if(isValid){ %>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script>
	Swal.fire({
		 position: 'top-50 start-50',
		 icon: 'success',
		 text: '새로운 비밀번호로 변경되어, 재로그인이 필요합니다.',
		 showConfirmButton: false,
		 timer: 2100
	}).then(function(){
		location.href="${pageContext.request.contextPath}/users/loginform.jsp";
	});    
	</script>
	<%}else{ %>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script>
	      Swal.fire({
			  position: 'top-50 start-50',
			  icon: 'error',
			  text: '비밀번호를 확인하세요.',
			  showConfirmButton: false,
			  timer: 1500
		}).then(function(){
			location.href="${pageContext.request.contextPath}/users/private/pwd_updateform.jsp";
		});	
	</script>
	<%} %>
</div>
</body>
</html>





