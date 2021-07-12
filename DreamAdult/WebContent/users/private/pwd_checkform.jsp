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
	
	#checkPwdForm{
		margin-left: 380px;
	}
	
	
</style>
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>

<div class="container">
	<div class="mt-4 text-center">
		<img  src="<%=request.getContextPath() %>/images/logo2.png" width="100" height="80">
		<h1 class="h3 mt-3 mb-3 fw-normal">비밀번호 확인</h1>
		<span><%=id %>님의 회원정보를 안전하게 보호하기 위해 비밀번호를 한번 더 확인해 주세요.</span>
	</div>
	<br />
	<br />
  	<form class="row g-3" action="updateform.jsp" method="post" id="checkPwdForm">
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
<p class="text-center mt-5 mb-3 text-muted">&copy; 2021-DreamAdult</p>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
	document.querySelector("#checkPwdForm").addEventListener("submit", function(e){
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
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>