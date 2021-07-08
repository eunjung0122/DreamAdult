<%@page import="test.study.dto.StudyBookMarkDto"%>
<%@page import="test.study.dao.StudyBookMarkDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String id=(String)session.getAttribute("id");

	StudyBookMarkDto dto=new StudyBookMarkDto();
	dto.setNum(num);
	dto.setId(id);

	boolean isSuccess=StudyBookMarkDao.getInstance().update2(dto);
	
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/users/private/bookmarked.jsp");
%>
