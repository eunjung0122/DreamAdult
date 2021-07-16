<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1. session 영역에서 로그인된 아이디를 읽어온다.
	String id=(String)session.getAttribute("id");
	//2. UsersDao 객체를 이용해서 가입된 정보를 얻어온다.
	UsersDto dto=UsersDao.getInstance().getData(id);
	//3. 응답한다.
	String lang=dto.getLang(); 
	
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<style>
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	.container>a{
		display:inline-block;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>
<div class="container" style="text-align:center;">
	<h1 style="margin:80px 0;">가입 정보</h1>
	<table class="table">
		<tr>
			<th>아이디</th>
			<td><%=id %></td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><%=dto.getNick() %></td>
		</tr>
		<tr>
			<th>회원등급</th>
			<td><%=dto.getGrade() %></td>
		</tr>
		<tr>
			<th>프로필 이미지</th>
			<td>
			<%if(dto.getProfile() == null){ %>	
				<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-emoji-sunglasses" viewBox="0 0 16 16">
  					<path d="M4.968 9.75a.5.5 0 1 0-.866.5A4.498 4.498 0 0 0 8 12.5a4.5 4.5 0 0 0 3.898-2.25.5.5 0 1 0-.866-.5A3.498 3.498 0 0 1 8 11.5a3.498 3.498 0 0 1-3.032-1.75zM7 5.116V5a1 1 0 0 0-1-1H3.28a1 1 0 0 0-.97 1.243l.311 1.242A2 2 0 0 0 4.561 8H5a2 2 0 0 0 1.994-1.839A2.99 2.99 0 0 1 8 6c.393 0 .74.064 1.006.161A2 2 0 0 0 11 8h.438a2 2 0 0 0 1.94-1.515l.311-1.242A1 1 0 0 0 12.72 4H10a1 1 0 0 0-1 1v.116A4.22 4.22 0 0 0 8 5c-.35 0-.69.04-1 .116z"/>
  					<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-1 0A7 7 0 1 0 1 8a7 7 0 0 0 14 0z"/>
				</svg>
			<%}else{ %>
				<img id="profileImage" 
					src="<%=request.getContextPath()%><%=dto.getProfile()%>"/>
			<%} %>	
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><a href="pwd_updateform.jsp" class="btn btn-custom-yellow">수정하기</a></td>
		</tr>
		<tr>
			<th>관심언어</th>
			<td>
				<label>
					<input type="checkbox" name="language" value="Java" <%=lang.contains("Java") ? "checked":""%> disabled/> 자바
				</label>
				<label>
					<input type="checkbox" name="language" value="Javascript" <%=lang.contains("Javascript") ? "checked":""%> disabled/> 자바스크립트
				</label>
				<label>
					<input type="checkbox" name="language" value="JSP" <%=lang.contains("JSP") ? "checked":""%> disabled/> JSP
				</label>
			</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=dto.getEmail() %></td>
		</tr>
		<tr>
			<th>가입일</th>
			<td><%=dto.getRegdate() %></td>
		</tr>
	</table>
	
	<a href="pwd_checkform.jsp" class="btn btn-custom-purple">개인정보 수정</a>
	<a class="btn btn-custom-dark" id="deleteConfirm">탈퇴</a>

</div>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
document.querySelector("#deleteConfirm").addEventListener("click", function(){
	   Swal.fire({
		   title: '회원탈퇴',
		   text: '탈퇴 시 회원님의 모든 정보가 삭제되고, 복구하실 수 없습니다. 정말 탈퇴하시겠습니까?',
		   icon: 'warning',
		   showDenyButton: true,
		   showCancelButton: true,
		   confirmButtonColor: '#000',
		   cancelButtonColor: '#f77028',
		   confirmButtonText: `Yes`,
		   denyButtonText: `Cancel`,
		 }).then((result) => {
		   if (result.isConfirmed) {
			   location.href="${pageContext.request.contextPath}/users/private/delete.jsp"
		   } else if (result.isDenied) {
			   location.href="${pageContext.request.contextPath}/users/private/info.jsp";
		   }
		 })
	   });
	   

</script>
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>





