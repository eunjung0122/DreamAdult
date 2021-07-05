<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.file.dao.FileCommentDao"%>
<%@page import="test.file.dto.FileCommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int ref_group = Integer.parseInt(request.getParameter("ref_group"));
	String target_nick = request.getParameter("target_nick");
	String content = request.getParameter("content");
	String comment_group = request.getParameter("comment_group");
	
	String writer = (String)session.getAttribute("id");
	String id=(String)session.getAttribute("id");
	String nick=UsersDao.getInstance().getData(id).getNick();
	
	int seq=FileCommentDao.getInstance().getSequence();
	
	FileCommentDto dto = new FileCommentDto();
	dto.setNum(seq);
	dto.setWriter(writer);
	dto.setNick(nick);
	dto.setTarget_nick(target_nick);
	dto.setContent(content);
	dto.setRef_group(ref_group);
	
	if(comment_group==null){
		//댓글의 글번호를 comment_group 번호로 사용한다.
		dto.setComment_group(seq);
	}else{
		dto.setComment_group(Integer.parseInt(comment_group));
	}
	FileCommentDao.getInstance().insert(dto);
	String cPath = request.getContextPath();
	response.sendRedirect(cPath + "/file/private/detail.jsp?num="+ref_group);
%>