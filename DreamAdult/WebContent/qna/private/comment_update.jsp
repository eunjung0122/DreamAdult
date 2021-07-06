<%@page import="test.qna.dao.QnACommentDao"%>
<%@page import="test.qna.dto.QnACommentDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String content=request.getParameter("content");
	
	QnACommentDto dto=new QnACommentDto();
	dto.setNum(num);
	dto.setContent(content);
	
	boolean isSuccess=QnACommentDao.getInstance().update(dto);
%>
{"isSuccess":<%=isSuccess %>}
