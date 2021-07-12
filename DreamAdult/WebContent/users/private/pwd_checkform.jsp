<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	String pwd=UsersDao.getInstance().getData(id).getPwd();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DreamAdult</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<style>
	#Pwd{
		border:1px solid #ddd;
		border-radius:42px;
		width: 400px;
	}
	.btn.btn-s {
		margin-top:0;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>

<div class="container">
	<h1>비밀번호 확인</h1>
  	<form class="row g-3" action="updateform.jsp" method="post" id="myForm">
	  <div class="col-auto">
	    <label for="Pwd" class="col-form-label">비밀번호</label>
	  </div>
	  <div class="col-auto">
	    <input type="password" class="form-control" name="Pwd" id="Pwd" placeholder="Password">
	  </div>
	  <div class="col-auto">
	    <button type="submit" class="btn btn-s btn-custom-dark">확인</button>
	  </div>
	</form> 
</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
	document.querySelector("#myForm").addEventListener("submit", function(e){
		let pwd=<%=pwd%>;
		let pwd1=document.querySelector("#Pwd").value;
		
		if(pwd != pwd1){
			Swal.fire({
 				 position: 'top-50 start-50',
 			 	 icon: 'warning',
 				 text: '비밀번호를 확인하세요!',
 				 showConfirmButton: false,
 			     timer: 1500
 			})
			e.preventDefault();//폼 전송 막기 
		}
	});
</script>
</body>
</html>