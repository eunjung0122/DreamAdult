<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>users/private/pwd_checkform.jsp</title>
</head>
<body>
<div class="container">
	<h1>개인정보 수정 전 비밀번호 확인 폼</h1>
	<form action="updateform.jsp" method="post" id="myForm">
		<div>
			<label for="Pwd">비밀번호</label>
			<input type="password" name="Pwd" id="Pwd"/>
		</div>
		<div>
			<label for="Pwd2">비밀번호 확인</label>
			<input type="password" id="Pwd2"/>
		</div>
		<button type="submit">확인</button>
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