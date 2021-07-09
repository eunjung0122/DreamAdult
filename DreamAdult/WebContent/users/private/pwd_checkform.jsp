<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/private/pwd_checkform.jsp</title>
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>


<div class="container">
	<h1>비밀번호 확인</h1>
		<form class="row g-3 mt-3" action="updateform.jsp" method="post" id="myForm">
			<div class="col-auto">
		    	<label for="Pwd" class="col-form-label">비밀번호</label>
		  	</div>
		  	<div class="col-auto">
		    	<input type="password" id="Pwd" name="Pwd" class="form-control">
		  	</div>
		  	<div class="col-auto">
		   		 <button type="submit" class="btn btn-primary">
		    		확인
		   		 </button>
		  	</div>
  		</form>
</div>
<script>
	//폼에 submit 이벤트가 일어났을때 실행할 함수를 등록하고 
	document.querySelector("#myForm").addEventListener("submit", function(e){
		let pwd1=document.querySelector("#pwd").value;
		let pwd2=document.querySelector("#pwd2").value;
		//새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
		if(pwd != pwd2){
			alert("비밀번호를 확인 하세요!");
			e.preventDefault();//폼 전송 막기 
		}
	});
</script>
</body>
</html>