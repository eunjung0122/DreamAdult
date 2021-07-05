<%@page import="test.qna.dao.QnACommentDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	boolean isSuccess=QnACommentDao.getInstance().delete(num);
%>
{"isSuccess":<%=isSuccess %>}