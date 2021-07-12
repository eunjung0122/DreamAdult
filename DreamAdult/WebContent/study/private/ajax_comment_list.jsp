<%@page import="java.util.List"%>
<%@page import="test.study.dao.StudyCommentDao"%>
<%@page import="test.study.dto.StudyCommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	int pageNum=Integer.parseInt(request.getParameter("pageNum"));
	int num=Integer.parseInt(request.getParameter("num"));
	 /*
	    [ 댓글 페이징 처리에 관련된 로직 ]
	 */
	 //한 페이지에 몇개씩 표시할 것인지
	 final int PAGE_ROW_COUNT=10;
	 
	 //보여줄 페이지의 시작 ROWNUM
	 int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	 //보여줄 페이지의 끝 ROWNUM
	 int endRowNum=pageNum*PAGE_ROW_COUNT;
	 
	 //원글의 글번호를 이용해서 해당글에 달린 댓글 목록을 얻어온다.
	 StudyCommentDto commentDto=new StudyCommentDto();
	 commentDto.setRef_group(num);
	 //1페이지에 해당하는 startRowNum 과 endRowNum 을 dto 에 담아서  
	 commentDto.setStartRowNum(startRowNum);
	 commentDto.setEndRowNum(endRowNum);
	 
	 //pageNum에 해당하는 댓글 목록만 select 되도록 한다. 
	 List<StudyCommentDto> commentList=
			 StudyCommentDao.getInstance().getList(commentDto);
	 
	 //원글의 글번호를 이용해서 댓글 전체의 갯수를 얻어낸다.
	 int totalRow=StudyCommentDao.getInstance().getCount(num);
	 //댓글 전체 페이지의 갯수
	 int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
%>
<%for(StudyCommentDto tmp: commentList){ %>
	<%if(tmp.getDeleted().equals("yes")){ %>
		<li>삭제된 댓글 입니다.</li>
   	<%
   		continue;
   	}%>
   	<%if(tmp.getNum()==tmp.getComment_group()) {%>
   		<li id="reli<%=tmp.getNum()%>" class="page-<%=pageNum%>">
   	<%}else{ %>
   		<li id="reli<%=tmp.getNum()%>" class="page-<%=pageNum%>" style="padding-left:50px;">
   			<svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
               	<path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
       		</svg>
   	<%} %>
   	<dl>
   		<dt>
   			<%if(tmp.getProfile() == null){ %>
	          	<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-emoji-sunglasses" viewBox="0 0 16 16">
  					<path d="M4.968 9.75a.5.5 0 1 0-.866.5A4.498 4.498 0 0 0 8 12.5a4.5 4.5 0 0 0 3.898-2.25.5.5 0 1 0-.866-.5A3.498 3.498 0 0 1 8 11.5a3.498 3.498 0 0 1-3.032-1.75zM7 5.116V5a1 1 0 0 0-1-1H3.28a1 1 0 0 0-.97 1.243l.311 1.242A2 2 0 0 0 4.561 8H5a2 2 0 0 0 1.994-1.839A2.99 2.99 0 0 1 8 6c.393 0 .74.064 1.006.161A2 2 0 0 0 11 8h.438a2 2 0 0 0 1.94-1.515l.311-1.242A1 1 0 0 0 12.72 4H10a1 1 0 0 0-1 1v.116A4.22 4.22 0 0 0 8 5c-.35 0-.69.04-1 .116z"/>
  					<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-1 0A7 7 0 1 0 1 8a7 7 0 0 0 14 0z"/>
				</svg>
	   		<%}else{ %>
	      		<img class="profile-image" src="${pageContext.request.contextPath}<%=tmp.getProfile()%>"/>
			<%} %>
	        <span><%=tmp.getNick() %></span>
	        <%if(tmp.getNum() != tmp.getComment_group()){ %>
            	@<i><%=tmp.getTarget_nick() %></i>
            <%} %>
            <span><%=tmp.getRegdate() %></span>
            <a data-num="<%=tmp.getNum() %>" href="javascript:" class="reply-link">답글</a>
	        <%if(id!=null && tmp.getWriter().equals(id)) {%>
	        	<a data-num="<%=tmp.getNum() %>" href="javascript:" class="update-link">수정</a>
	            <a data-num="<%=tmp.getNum() %>" href="javascript:" class="delete-link">삭제</a>
	        <%} %>
	    </dt>
	   	<dd>
   			<pre id="pre<%=tmp.getNum()%>"><%=tmp.getContent() %></pre>
   		</dd>
   	</dl>
   	<form id="reForm<%=tmp.getNum() %>" class="animate__animated comment-form re-insert-form" action="comment_insert.jsp" method="post">
   		<input type="hidden" name="ref_group" value="<%=num%>"/>
   		<input type="hidden" name="target_nick" value="<%=tmp.getNick()%>"/>
   		<input type="hidden" name="comment_group" value="<%=tmp.getComment_group()%>"/>
   		<textarea name="content"></textarea>
   		<button type="submit">등록</button>
   	</form>
   	<%if(tmp.getWriter().equals(id)) {%>
   		<form id="updateForm<%=tmp.getNum() %>" class="comment-form update-form" action="comment_update.jsp" method="post">
	    	<input type="hidden" name="num" value="<%=tmp.getNum() %>" />
		    <textarea class="form-control" name="content"><%=tmp.getContent() %></textarea>
		    <button type="submit">수정</button>
		</form>
   	<%} %>
   	</li>
<%} %>	