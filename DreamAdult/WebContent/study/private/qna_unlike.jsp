<%@page import="test.qna.dao.QnALikeDao"%>
<%@page import="test.qna.dto.QnALikeDto"%>
<%@page import="test.qna.dao.QnADao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String id=(String)session.getAttribute("id");
	
	QnALikeDto dto=new QnALikeDto();
	dto.setNum(num);
	dto.setId(id);
	
	boolean isSuccess=QnALikeDao.getInstance().update2(dto);
%>
{"isSuccess":<%=isSuccess %>}
