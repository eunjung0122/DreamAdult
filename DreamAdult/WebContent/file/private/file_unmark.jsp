<%@page import="test.file.dao.FileBookMarkDao"%>
<%@page import="test.file.dto.FileBookMarkDto"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	String id=(String)session.getAttribute("id");
	
	FileBookMarkDto dto=new FileBookMarkDto();
	dto.setNum(num);
	dto.setId(id);
	
	boolean isSuccess=FileBookMarkDao.getInstance().update2(dto);
%>
{"isSuccess":<%=isSuccess %>}