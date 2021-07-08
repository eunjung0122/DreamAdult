<%@page import="test.study.dao.StudyBookMarkDao"%>
<%@page import="test.study.dto.StudyBookMarkDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String id=(String)session.getAttribute("id");
	
	StudyBookMarkDto dto=new StudyBookMarkDto();
	dto.setNum(num);
	dto.setId(id);
	
	boolean isSuccess=StudyBookMarkDao.getInstance().update2(dto);
%>
{"isSuccess":<%=isSuccess %>}