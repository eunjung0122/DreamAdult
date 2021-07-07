<%@page import="test.file.dao.FileLikeDao"%>
<%@page import="test.file.dto.FileLikeDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String id=(String)session.getAttribute("id");
	
	FileLikeDto dto=new FileLikeDto();
	dto.setNum(num);
	dto.setId(id);
	
	boolean isSuccess = FileLikeDao.getInstance().update2(dto);
%>
{"isSuccess":<%=isSuccess %>}