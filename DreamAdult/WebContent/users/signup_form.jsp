<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" />
<style>
.userform-page{
	background: #f8d348;
	padding: 60px 0 80px;
	text-align:center;
}
.logo-wrap{
	background:#fff;
	border-radius:50%;
	width:200px;
	height:200px;
	margin:0 auto;
	margin-bottom:40px;
}
.logo-wrap img{
	position:relative;
	top:50%;
	transform:translateY(-50%);
}
	.btn-primary{
	  	background-color: #3c64ff;
	  	    border-color: #3c64ff;
	  }
	  .btn-primary:hover{
	  	background-color: #3258ed;
	  	border-color: #3258ed;
	  }
	.bd-placeholder-img {
	    font-size: 1.125rem;
	    text-anchor: middle;
	    -webkit-user-select: none;
	    -moz-user-select: none;
	    user-select: none;
	  }
	
	@media (min-width: 768px) {
	    .bd-placeholder-img-lg {
	      font-size: 3.5rem;
	    }
	  }
	.container {
		max-width: 960px;
	  }
	  
	 #signupForm{
	 	text-align:center;
	 }
</style>
    
</head>
<body>
<jsp:include page="../include/navber.jsp"></jsp:include>
<div class="userform-page">
<div class="container">
		<div class="logo-wrap">
			<img  src="../images/logo2.png" width="100" height="80">
		</div>
		<form action="signup.jsp" method="post" id="signupForm">
			<div class="col-6">
				<label class="control-label" for="id">아이디
					<small class="form-text text-muted">영문자 소문자로 시작하고 5글자~10글자 이내로 입력하세요.</small>
				</label>
				<input class="form-control" type="text" name="id" id="id"/>
				<div class="invalid-feedback">사용할수 없는 아이디 입니다.</div>
			</div>
			<div class="col-6 mt-2">
				<label class="control-label" for="nick">닉네임</label>
				<input class="form-control" type="text" name="nick" id="nick"/>
				<div class="invalid-feedback">사용할수 없는 닉네임 입니다.</div>
			</div>
			<div class="col-6 mt-2">
				<label class="control-label" for="pwd">비밀번호
					<small class="form-text text-muted">5글자~10글자 이내로 입력하세요.</small>
				</label>
				<input class="form-control" type="password" name="pwd" id="pwd"/>
				<div class="invalid-feedback">비밀번호를 확인 하세요.</div>
			</div>
			<div class="col-6 mt-2">
				<label class="control-label" for="pwd2">비밀번호 확인</label>
				<input class="form-control" type="password" name="pwd2" id="pwd2"/>
			</div>
			<div class="col-6 mt-2">
				<label class="control-label form-label" for="email">이메일</label>
				<input class="form-control" type="text" name="email" id="email" placeholder="you@example.com"/>
				<div class="invalid-feedback">이메일 형식을 확인 하세요.</div>
			</div> 
	
			<fieldset>
				<legend class="mt-4">관심있는 언어 선택</legend>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="checkbox" name="language" id="lan1" value="Java"/>
					<label class="form-check-label" for="lan1">자바</label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="checkbox" name="language" id="lan2" value="Javascript"/>
					<label class="form-check-label" for="lan2">자바스크립트</label>
				</div>
				<div class="form-check form-check-inline">
					<input class="form-check-input" type="checkbox" name="language" id="lan3" value="JSP"/>
					<label class="form-check-label" for="lan3">JSP</label>
				</div>
			</fieldset>
			<hr class="my-4">
			<button class="w-50 btn btn-lg btn-custom-dark " type="submit">가입</button>
		</form>
	</div>


</div>

	
<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>
<script>
	//아이디, 비밀번호, 이메일의 유효성 여부를 관리한 변수 만들고 초기값 대입
	let isIdValid=false;
	let isPwdValid=false;
	let isEmailValid=false;

	//아이디를 입력했을때(input) 실행할 함수 등록 
	document.querySelector("#id").addEventListener("input", function(){
		//일단 is-valid,  is-invalid 클래스를 제거한다.
		document.querySelector("#id").classList.remove("is-valid");
		document.querySelector("#id").classList.remove("is-invalid");
		
		//1. 입력한 아이디 value 값 읽어오기  
		let inputId=this.value;
		//입력한 아이디를 검증할 정규 표현식
		const reg_id=/^[a-z].{4,9}$/;
		//만일 입력한 아이디가 정규표현식과 매칭되지 않는다면
		if(!reg_id.test(inputId)){
			isIdValid=false; //아이디가 매칭되지 않는다고 표시하고 
			// is-invalid 클래스를 추가한다. 
			document.querySelector("#id").classList.add("is-invalid");
			return; //함수를 여기서 끝낸다 (ajax 전송 되지 않도록)
		}
		
		//2. util 에 있는 함수를 이용해서 ajax 요청하기
		ajaxPromise("checkid.jsp", "get", "inputId="+inputId)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			console.log(data);
			//data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
			if(data.isExist){//만일 존재한다면
				//사용할수 없는 아이디라는 피드백을 보이게 한다. 
				isIdValid=false;
				// is-invalid 클래스를 추가한다. 
				document.querySelector("#id").classList.add("is-invalid");
			}else{
				isIdValid=true;
				document.querySelector("#id").classList.add("is-valid");
			}
		});
	});
	
	//아이디를 입력했을때(input) 실행할 함수 등록 
	document.querySelector("#nick").addEventListener("input", function(){
		//일단 is-valid,  is-invalid 클래스를 제거한다.
		document.querySelector("#nick").classList.remove("is-valid");
		document.querySelector("#nick").classList.remove("is-invalid");
		
		let inputNick=this.value;
		
		//2. util 에 있는 함수를 이용해서 ajax 요청하기
		ajaxPromise("checknick.jsp", "get", "inputNick="+inputNick)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			console.log(data);
			//data 는 {isExist:true} or {isExist:false} 형태의 object 이다.
			if(data.isExist){//만일 존재한다면
				//사용할수 없는 아이디라는 피드백을 보이게 한다. 
				isIdValid=false;
				// is-invalid 클래스를 추가한다. 
				document.querySelector("#nick").classList.add("is-invalid");
			}else{
				isIdValid=true;
				document.querySelector("#nick").classList.add("is-valid");
			}
		});
	});
	
	//비밀 번호를 확인 하는 함수 
	function checkPwd(){
		document.querySelector("#pwd").classList.remove("is-valid");
		document.querySelector("#pwd").classList.remove("is-invalid");
		
		const pwd=document.querySelector("#pwd").value;
		const pwd2=document.querySelector("#pwd2").value;
		
		// 최소5글자 최대 10글자인지를 검증할 정규표현식
		const reg_pwd=/^.{5,10}$/;
		if(!reg_pwd.test(pwd)){
			isPwdValid=false;
			document.querySelector("#pwd").classList.add("is-invalid");
			return; //함수를 여기서 종료
		}
		
		if(pwd != pwd2){//비밀번호와 비밀번호 확인란이 다르면
			//비밀번호를 잘못 입력한것이다.
			isPwdValid=false;
			document.querySelector("#pwd").classList.add("is-invalid");
		}else{
			isPwdValid=true;
			document.querySelector("#pwd").classList.add("is-valid");
		}
	}
	
	//비밀번호 입력란에 input 이벤트가 일어 났을때 실행할 함수 등록
	document.querySelector("#pwd").addEventListener("input", checkPwd);
	document.querySelector("#pwd2").addEventListener("input", checkPwd);
	
	//이메일을 입력했을때 실행할 함수 등록
	document.querySelector("#email").addEventListener("input", function(){
		document.querySelector("#email").classList.remove("is-valid");
		document.querySelector("#email").classList.remove("is-invalid");
		
		//1. 입력한 이메일을 읽어와서
		const inputEmail=this.value;
		//2. 이메일을 검증할 정규 표현식 객체를 만들어서
		const reg_email=/@/;
		//3. 정규표현식 매칭 여부에 따라 분기하기
		if(reg_email.test(inputEmail)){//만일 매칭된다면
			isEmailValid=true;
			document.querySelector("#email").classList.add("is-valid");
		}else{
			isEmailValid=false;
			document.querySelector("#email").classList.add("is-invalid");
		}
	});
	
	
	//폼에 submit 이벤트가 발생했을때 실행할 함수 등록
	document.querySelector("#signupForm").addEventListener("submit", function(e){
		//console.log(e);
		/*
			입력한 아이디, 비밀번호, 이메일의 유효성 여부를 확인해서 하나라도 유효 하지 않으면
			e.preventDefault(); 
			가 수행 되도록 해서 폼의 제출을 막아야 한다. 
		*/
		//폼 전체의 유효성 여부 알아내기 
		let isFormValid = isIdValid && isPwdValid && isEmailValid;
		if(!isFormValid){//폼이 유효하지 않으면
			//폼 전송 막기 
			e.preventDefault();
		}	
	});
</script>

<footer style="height:400px; border-top:1px solid #ddd; margin-top:80px;">
	<div class="container">
		<p style="padding-top:60px;">© dream adult. All rights reserved.</p>
	</div>
</footer>

</body>
</html>





