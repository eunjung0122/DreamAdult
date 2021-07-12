<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//로그 아웃은 session 영역에 저장된 id 값을 삭제하면 된다.
	session.removeAttribute("id");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/logout.jsp</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script>
	Swal.fire({
		  position: 'top-50 start-50',
		  icon: 'success',
		  title: 'Bye bye!',
		  showConfirmButton: false,
		  timer: 1500
	}).then(function(){
		location.href="<%=request.getContextPath()%>/index.jsp";
	});
	</script>
</body>
</html>