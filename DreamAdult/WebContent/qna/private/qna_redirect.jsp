<%@page import="test.qna.dao.QnABookMarkDao"%>
<%@page import="test.qna.dto.QnABookMarkDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String id=(String)session.getAttribute("id");

	QnABookMarkDto dto=new QnABookMarkDto();
	dto.setNum(num);
	dto.setId(id);

	boolean isSuccess=QnABookMarkDao.getInstance().update2(dto);
	
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/users/private/bookmarked.jsp");
%>
