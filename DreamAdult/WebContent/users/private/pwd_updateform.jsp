<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/pwd_updateform.jsp</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" />
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<style>

.container {
	max-width: 960px;
}

#changePwdForm{
	width: 100%;
	text-align: center;
}

#one{
	margin-left: 500px;
}

#two{
	margin-left: 500px; 	
} 

#three{
	margin-left: 500px; 
} 

</style>


</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>
<div class="container">
	<div class="mt-4 text-center">
		<img  src="<%=request.getContextPath() %>/images/logo2.png" width="100" height="80">
		<h1 class="h3 mt-3 mb-3 fw-normal">비밀번호 변경</h1>
	</div>
	
	<form action="pwd_update.jsp" method="post" id="changePwdForm">
		<div class="col-3" id="one">
			<label class="control-label" for="pwd">현재 비밀 번호</label>
			<input class="form-control" type="password" name="pwd" id="pwd"/>
		</div>
		<div class="col-3 mt-2" id="two">
			<label class="control-label" for="newPwd">새 비밀번호</label>
			<small class="form-text text-muted">5글자~10글자 이내로 입력하세요.</small>
			<input class="form-control" type="password" name="newPwd" id="newPwd"/>
			<div class="invalid-feedback">입력하신 비밀번호를 확인 하세요.</div>
		</div>
		<div class="col-3 mt-2" id="three">
			<label class="control-label" for="newPwd2">새 비밀번호 확인</label>
			<input class="form-control" type="password" id="newPwd2"/>
		</div>
		
		<hr class="my-4">
		<button class="btn btn-lg btn-custom-yellow" type="submit">비밀번호 변경</button>&nbsp;&nbsp;&nbsp;
		<button class="btn btn-lg btn-custom-gray" type="reset">Reset</button>
	</form>
</div>
<p class="text-center mt-5 mb-3 text-muted">&copy; 2021-DreamAdult</p>
<script>
let isNewPwdValid=false;

	function checkNewPwd(){
		document.querySelector("#newPwd").classList.remove("is-valid");
		document.querySelector("#newPwd").classList.remove("is-invalid");
		
		const newPwd=document.querySelector("#newPwd").value;
		const newPwd2=document.querySelector("#newPwd2").value;
		
		// 최소5글자 최대 10글자인지를 검증할 정규표현식
		const reg_newPwd=/^.{5,10}$/;
		if(!reg_newPwd.test(newPwd)){
			isNewPwdValid=false;
			document.querySelector("#newPwd").classList.add("is-invalid");
			return; //함수를 여기서 종료
		}
		
		if(newPwd != newPwd2){//비밀번호와 비밀번호 확인란이 다르면
			//비밀번호를 잘못 입력한것이다.
			isNewPwdValid=false;
			document.querySelector("#newPwd").classList.add("is-invalid");
		}else{
			isNewPwdValid=true;
			document.querySelector("#newPwd2").classList.add("is-valid");
		}
	}
	
	//비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
	document.querySelector("#newPwd").addEventListener("input", checkNewPwd);
	document.querySelector("#newPwd2").addEventListener("input", checkNewPwd);
	
	document.querySelector("#changePwdForm").addEventListener("submit", function(e){
		let isFormNotValid= isNewPwdValid;
		if(!isFormNotValid){
			e.preventDefault();
		}
	});
</script>
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>


