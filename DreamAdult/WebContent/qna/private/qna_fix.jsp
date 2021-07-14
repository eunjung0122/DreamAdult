<%@page import="test.qna.dto.QnADto"%>
<%@page import="test.qna.dao.QnADao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	
	QnADto dto=new QnADto();
	dto.setNum(num);
	
	boolean isSuccess=QnADao.getInstance().fix(dto);
%>
{"isSuccess":<%=isSuccess %>}
