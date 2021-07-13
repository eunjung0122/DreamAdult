<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//폼 전송되는 가입할 회원의 정보를 읽어온다.
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	String nick=request.getParameter("nick");
	String email=request.getParameter("email");
	String[] language=request.getParameterValues("language");
	String grade="child";
	
	String lang="";
	if(language != null){
		System.out.println("language.length:"+language.length);
		for(String tmp: language){
			System.out.println(tmp);
			lang = lang+tmp+"/";
		}	
	}
	//UsersDto 객체에 회원의 정보를 담고
	UsersDto dto=new UsersDto();
	dto.setId(id);
	dto.setPwd(pwd);
	dto.setNick(nick);
	dto.setEmail(email);
	dto.setLang(lang);
	dto.setGrade(grade);
	//UsersDao 객체를 이용해서 DB 에 저장한다.
	boolean isSuccess=UsersDao.getInstance().insert(dto);
	//응답하기 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
</head>
<body>
<div class="container">
	<%if(isSuccess){ %>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script>
   	Swal.fire({
		 position: 'top-50 start-50',
		 icon: 'success',
		 title: 'Welcome ours new member',
		 text: '<%=id%> 님, 로그인 페이지로 이동됩니다.',
		 showConfirmButton: false,
		 timer: 2000
	}).then(function(){
		location.href="${pageContext.request.contextPath}/users/loginform.jsp";
	});
   	</script>
		<%}else{ %>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
		<script>
			Swal.fire({
				  position: 'top-50 start-50',
				  icon: 'error',
				  title: 'Your membership has not been processed.',
				  text: '회원가입 페이지로 이동됩니다.',
				  showConfirmButton: false,
				  timer: 1500
			}).then(function(){
				location.href="${pageContext.request.contextPath}/users/signup_form.jsp";
			});
		</script>	
		<%} %>
</div>	
</body>
</html>







