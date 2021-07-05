<%@page import="test.study.dao.StudyCommentDao"%>
<%@page import="test.study.dto.StudyCommentDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String content=request.getParameter("content");
	
	StudyCommentDto dto=new StudyCommentDto();
	dto.setNum(num);
	dto.setContent(content);
	
	boolean isSuccess=StudyCommentDao.getInstance().update(dto);
%>
{"isSuccess":<%=isSuccess %>}
