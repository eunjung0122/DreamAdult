<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// "inputId" 라는 파라미터로 전달되는 문자열 읽어오기
	String inputNick=request.getParameter("inputNick");
	//DB 에서 가입된 아이디가 이미 존재하는지 여부를 얻어낸다.
	boolean isExist=UsersDao.getInstance().isExistNick(inputNick);
%>    
{"isExist": <%=isExist%>}