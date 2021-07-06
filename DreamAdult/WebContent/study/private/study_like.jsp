<%@page import="test.study.dao.StudyLikeDao"%>
<%@page import="test.study.dto.StudyLikeDto"%>
<%@page import="test.study.dao.StudyDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String id=(String)session.getAttribute("id");
	
	StudyLikeDto dto=new StudyLikeDto();
	dto.setNum(num);
	dto.setId(id);
	
	boolean isSuccess=StudyLikeDao.getInstance().update(dto);
%>
{"isSuccess":<%=isSuccess %>}
