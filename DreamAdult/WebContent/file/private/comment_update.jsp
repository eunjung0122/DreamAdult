<%@page import="test.file.dao.FileCommentDao"%>
<%@page import="test.file.dto.FileCommentDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String content = request.getParameter("content");
	
	FileCommentDto dto = new FileCommentDto();
	dto.setNum(num);
	dto.setContent(content);
	
	boolean isSuccess = FileCommentDao.getInstance().update(dto);
	
%>
{"isSuccess":<%=isSuccess %>}