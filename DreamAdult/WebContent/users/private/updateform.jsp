<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//session 영역에 저장된 아이디를 이용해서 
	String id=(String)session.getAttribute("id");
	//개인정보를 불러와서
	UsersDto dto=UsersDao.getInstance().getData(id);
	//개인정보 수정폼에 출력해 준다. 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/private/updateform.jsp</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<style>
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	#imageForm{
		display: none;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>
<div class="container">
	<h1 class="mb-3">개인정보 수정</h1>
	<a class="mb-3" id="profileLink" href="javascript:">
		<%if(dto.getProfile()==null){ %>
			<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-emoji-sunglasses" viewBox="0 0 16 16">
				  <path d="M4.968 9.75a.5.5 0 1 0-.866.5A4.498 4.498 0 0 0 8 12.5a4.5 4.5 0 0 0 3.898-2.25.5.5 0 1 0-.866-.5A3.498 3.498 0 0 1 8 11.5a3.498 3.498 0 0 1-3.032-1.75zM7 5.116V5a1 1 0 0 0-1-1H3.28a1 1 0 0 0-.97 1.243l.311 1.242A2 2 0 0 0 4.561 8H5a2 2 0 0 0 1.994-1.839A2.99 2.99 0 0 1 8 6c.393 0 .74.064 1.006.161A2 2 0 0 0 11 8h.438a2 2 0 0 0 1.94-1.515l.311-1.242A1 1 0 0 0 12.72 4H10a1 1 0 0 0-1 1v.116A4.22 4.22 0 0 0 8 5c-.35 0-.69.04-1 .116z"/>
				  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-1 0A7 7 0 1 0 1 8a7 7 0 0 0 14 0z"/>
			</svg>
		<%}else{ %>
			<img id="profileImage" 
				src="<%=request.getContextPath() %><%=dto.getProfile() %>" />
		<%} %>
	</a>
	<form action="update.jsp" method="post">
		<input type="hidden" name="profile" 
			value="<%=dto.getProfile()==null ? "empty" : dto.getProfile()%>"/>
		<div class="mb-3">
			<label for="id">아이디</label>
			<input class="form-control" type="text" id="id" value="<%=id %>" disabled/>
		</div>
		<div class="mb-3">
			<label for="nick">닉네임</label>
			<input class="form-control" type="text" name="nick" id="nick" value="<%=dto.getNick() %>" />
		</div>
		<div class="mb-3">
			<label for="email">이메일</label>
			<input class="form-control" type="text" name="email" id="email" value="<%=dto.getEmail()%>"/>
		</div>
		<button class="btn btn-s btn-custom-dark" type="submit">수정반영</button>
	</form>
	
	<form action="ajax_profile_upload.jsp" method="post" 
				id="imageForm" enctype="multipart/form-data">
		<input type="file" name="image" id="image" 
			accept=".jpg, .jpeg, .png, .JPG, .JPEG, .gif"/>
	</form>
</div>
<script src="<%=request.getContextPath() %>/js/gura_util.js"></script>
<script>
	//프로필 이미지 링크를 클릭하면 
	document.querySelector("#profileLink").addEventListener("click", function(){
		// input type="file" 을 강제 클릭 시킨다. 
		document.querySelector("#image").click();
	});
	//이미지를 선택했을때 실행할 함수 등록 
	document.querySelector("#image").addEventListener("change", function(){
		
		let form=document.querySelector("#imageForm");
		
		// gura_util.js 에 정의된 함수를 호출하면서 ajax 전송할 폼의 참조값을 전달하면 된다. 
		ajaxFormPromise(form)
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			// data 는 {imagePath:"/upload/xxx.jpg"} 형식의 object 이다.
			console.log(data);
			let img=`<img id="profileImage" src="<%=request.getContextPath()%>\${data.imagePath}"/>`;
			document.querySelector("#profileLink").innerHTML=img;
			// input name="profile" 요소의 value 값으로 이미지 경로 넣어주기
			document.querySelector("input[name=profile]").value=data.imagePath;
		});
		/*  util 을 사용하지 않는 코드는 아래와 같다  
		
		let form=document.querySelector("#imageForm");
		const url=form.getAttribute("action");
		const method=form.getAttribute("method");
		//폼에 입력한 데이터를 FormData 에 담고 
		let data=new FormData(form);
		// fetch() 함수가 리턴하는 Promise 객체를 
		fetch(url,{
			method:method,
			body:data
		})
		.then(function(response){
			return response.json();
		})
		.then(function(data){
			console.log(data);
			
		});
		*/
	});
</script>
</body>
</html>










