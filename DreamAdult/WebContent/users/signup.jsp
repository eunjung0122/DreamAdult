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
<title>/users/signup.jsp</title>
</head>
<body>
<div class="container">
	<%if(isSuccess){ %>
		<p> 
			<strong><%=id %></strong> 회원님 가입 되었습니다.
			<a href="loginform.jsp">로그인 하러가기</a>
		</p>
	<%}else{ %>
		<p>
			가입 실패!
			<a href="signup_form.jsp">다시 작성하러 가기</a>
		</p>
	<%} %>
</div>	
</body>
</html>







