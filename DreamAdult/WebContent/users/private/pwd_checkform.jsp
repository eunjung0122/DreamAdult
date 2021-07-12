<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/private/pwd_checkform.jsp</title>
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
<script>
	//폼에 submit 이벤트가 일어났을때 실행할 함수를 등록하고 
	document.querySelector("#myForm").addEventListener("submit", function(e){
		let pwd1=document.querySelector("#pwd").value;
		//새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
		if(pwd != pwd1){
			alert("비밀번호를 확인 하세요!");
			e.preventDefault();//폼 전송 막기 
		}
	});
</script>
</body>
</html>