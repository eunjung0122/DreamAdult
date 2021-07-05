<%@page import="test.study.dao.StudyCommentDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	boolean isSuccess=StudyCommentDao.getInstance().delete(num);
%>
{"isSuccess":<%=isSuccess %>}