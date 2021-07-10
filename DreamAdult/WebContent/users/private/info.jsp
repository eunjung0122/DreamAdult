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
<title>/users/private/info.jsp</title>
<style>
	/* 프로필 이미지를 작은 원형으로 만든다 */
	#profileImage{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
</style>
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>
<div class="container">
	<h1>가입 정보 입니다.</h1>
	<table>
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
				<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
				  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
				  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
				</svg>
			<%}else{ %>
				<img id="profileImage" 
					src="<%=request.getContextPath()%><%=dto.getProfile()%>"/>
			<%} %>	
			</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td><a href="pwd_updateform.jsp">수정하기</a></td>
		</tr>
		<tr>
			<th>관심언어</th>
			<td>
				<label>
					<input type="checkbox" name="language" value="Java" <%=lang.contains("Java") ? "checked":""%>/> 자바
				</label>
				<label>
					<input type="checkbox" name="language" value="Javascript" <%=lang.contains("Javascript") ? "checked":""%>/> 자바스크립트
				</label>
				<label>
					<input type="checkbox" name="language" value="JSP" <%=lang.contains("JSP") ? "checked":""%>/> JSP
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
	<a href="pwd_checkform.jsp">개인정보 수정</a>
	<a class="btn btn-custom-dark" id="deleteConfirm">탈퇴</a>
	<a href="../../index.jsp">인덱스로 가기</a>
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
</body>
</html>





