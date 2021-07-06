<%@page import="test.file.dao.FileCommentDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	boolean isSuccess = FileCommentDao.getInstance().delete(num);
%>
{"isSuccess":<%=isSuccess %>}