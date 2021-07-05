<%@page import="test.qna.dto.QnACommentDto"%>
<%@page import="test.qna.dao.QnACommentDao"%>
<%@page import="test.users.dao.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int ref_group=Integer.parseInt(request.getParameter("ref_group"));
	String target_nick=request.getParameter("target_nick");
	String content=request.getParameter("content");
	String comment_group=request.getParameter("comment_group");
	
	//작성자(아이디)
	String writer=(String)session.getAttribute("id");
	
	//작성자(닉네임)
	String id=(String)session.getAttribute("id");
	String nick=UsersDao.getInstance().getData(id).getNick();
	
	//댓글의 시퀀스 번호 미리 얻어내기
	int seq=QnACommentDao.getInstance().getSequence();
	
	//저장할 댓글의 정보를 dto 에 담기
	QnACommentDto dto=new QnACommentDto();
	dto.setNum(seq);
	dto.setWriter(writer);
	dto.setNick(nick);
	dto.setTarget_nick(target_nick);
	dto.setContent(content);
	dto.setRef_group(ref_group);
	
	
	//원글의 댓글인 경우
	if(comment_group==null){
		//댓글의 글번호를 comment_group 번호로 사용한다.
		dto.setComment_group(seq);
	}else{
		dto.setComment_group(Integer.parseInt(comment_group));
	}
	
	//댓글 정보를 DB에 저장하기
	QnACommentDao.getInstance().insert(dto);
	
	//원글 자세히보기(detail) 로 리다일렉트 이동
	String cPath=request.getContextPath();
	response.sendRedirect(cPath+"/qna/private/detail.jsp?num="+ref_group);
		
%>
