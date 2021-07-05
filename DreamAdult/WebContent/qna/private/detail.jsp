<%@page import="java.util.List"%>
<%@page import="test.qna.dao.QnACommentDao"%>
<%@page import="test.qna.dto.QnACommentDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.qna.dto.QnADto"%>
<%@page import="test.qna.dao.QnADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	QnADao.getInstance().addViewCount(num);
	
	String category=request.getParameter("category");
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	if(keyword==null){
		keyword="";
		condition="";
	}
	if(category==null){
		category="whole";
		
	}
	String encodedK=URLEncoder.encode(keyword);
	
	QnADto dto=new QnADto();
	dto.setNum(num);
	
	if(category.equals("whole")&&!keyword.equals("")){
		if(condition.equals("title")){
			dto.setTitle(keyword);
			dto=QnADao.getInstance().getDataT(dto);
			
		}else if(condition.equals("nick")){
			dto.setNick(keyword);
			dto=QnADao.getInstance().getDataN(dto);
			
		}else if(condition.equals("title_content")){
			dto.setTitle(keyword);
			dto.setContent(keyword);
			dto=QnADao.getInstance().getDataTC(dto);
		}
	}else if(category.equals("whole")&&keyword.equals("")){
		dto=QnADao.getInstance().getData(dto);
	}else if(keyword.equals("")&&!category.equals("whole")){
		dto.setCategory(category);
		dto=QnADao.getInstance().getDataC(dto);
	}else if(!category.equals("whole")&&!keyword.equals("")){
		if(condition.equals("title")){
			dto.setCategory(category);
			dto.setTitle(keyword);
			dto=QnADao.getInstance().getDataTCa(dto);
			
		}else if(condition.equals("nick")){
			dto.setCategory(category);
			dto.setNick(keyword);
			dto=QnADao.getInstance().getDataNCa(dto);
			
		}else if(condition.equals("title_content")){
			dto.setCategory(category);
			dto.setTitle(keyword);
			dto.setContent(keyword);
			dto=QnADao.getInstance().getDataTCCa(dto);
		}
	}
	
	String id=(String)session.getAttribute("id");

	//글 하나의 정보를 DB에서 불러온다.
	QnADto dto2=QnADao.getInstance().getData(num);
	
	//원글의 글번호를 이용해서 해당글에 달린 댓글목록을 얻어온다.
	QnACommentDto commentDto=new QnACommentDto();
	commentDto.setRef_group(num);
	
	List<QnACommentDto> commentList=
			QnACommentDao.getInstance().getList(commentDto);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/qna/private/detail.jsp</title>
<style>
	.comment-form{
		display: none;
	}
</style>
</head>
<body>
<div class="container">
	<%if(dto.getPrevNum()!=0){ %>
      <a href="detail.jsp?num=<%=dto.getPrevNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>&category=<%=category%>">이전글</a>
   <%} %>
   <%if(dto.getNextNum()!=0){ %>
      <a href="detail.jsp?num=<%=dto.getNextNum() %>&keyword=<%=encodedK %>&condition=<%=condition%>&category=<%=category%>">다음글</a>
   <%} %>
   <% if(!keyword.equals("")&&!category.equals("whole")){ %>
      <p>   
      	 <strong><%=category %></strong> 분류,
         <strong><%=condition %></strong> 조건, 
         <strong><%=keyword %></strong> 검색어로 검색된 내용 자세히 보기 
      </p>
   <%}else if(keyword.equals("")&&!category.equals("whole")) {%>
   		<p>
   			<strong><%=category %></strong>로 분류된 내용 자세히 보기
   		</p>
   <%}else if(category.equals("whole")&&!keyword.equals("")) {%>
   		<p>   
         <strong><%=condition %></strong> 조건, 
         <strong><%=keyword %></strong> 검색어로 검색된 내용 자세히 보기 
      	</p>
   <%} %>

	<table class="table">
      <tr>
         <th>글번호</th>
         <td><%=dto.getNum() %></td>
      </tr>
      <tr>
      	<th>말머리</th>
      	<td><%=dto.getCategory() %></td>
      </tr>
      <tr>
         <th>작성자</th>
         <td><%=dto.getNick() %></td>
      </tr>
      <tr>
         <th>제목</th>
         <td><%=dto.getTitle() %></td>
      </tr>
      <tr>
         <th>조회수</th>
         <td><%=dto.getViewCount() %></td>
      </tr>
      <tr>
         <th>등록일</th>
         <td><%=dto.getRegdate() %></td>
      </tr>
      <tr>
         <td colspan="2">
            <div class="content form-control"><%=dto.getContent() %></div>
         </td>
      </tr>
   </table>
   <ul>
   		<li><a href="<%=request.getContextPath()%>/qna/list.jsp">목록보기</a></li>
   		<%if(dto.getWriter().equals(id)) {%>
   			<li><a href="<%=request.getContextPath()%>/qna/private/updateform.jsp?num=<%=dto.getNum()%>">수정</a></li>
   			<li><a href="<%=request.getContextPath()%>/qna/private/delete.jsp?num=<%=dto.getNum()%>"
   					onclick="return confirm('이 글 삭제를 원하시는 게 맞나요?');">삭제</a></li>
   		<%} %>
   </ul>
   <div class="comments">
   		<ul>
   			<%for(QnACommentDto tmp: commentList){ %>
	   			<%if(tmp.getDeleted().equals("yes")){ %>
	               <li>삭제된 댓글 입니다.</li>
	            <% 
	               continue;
	            }%>
   				<li id="reli<%=tmp.getNum()%>">
   					<dl>
   						<dt>
   							<a data-num="<%=tmp.getNum() %>" href="javascript:" class="reply-link">답글</a>
   						<%if(id != null && tmp.getWriter().equals(id)){ %>
                     		<a data-num="<%=tmp.getNum() %>" class="update-link" href="javascript:">수정</a>
                     		<a data-num="<%=tmp.getNum() %>" class="delete-link" href="javascript:">삭제</a>
                 		<%} %>
   						</dt>
   						<dd>
   							<pre id="pre<%=tmp.getNum()%>"><%=tmp.getContent() %></pre>
   						</dd>
   					</dl>
   					<form id="reForm<%=tmp.getNum() %>" class="comment-form re-insert-form" action="comment_insert.jsp" method="post">
                  		<input type="hidden" name="ref_group" value="<%=dto.getNum()%>"/>
                  		<input type="hidden" name="target_id" value="<%=tmp.getWriter()%>"/>
                  		<input type="hidden" name="comment_group" value="<%=tmp.getComment_group()%>"/>
                  		<textarea name="content"></textarea>
                  		<button type="submit">등록</button>
               		</form> 
   					<%if(tmp.getWriter().equals(id)){ %>
   					<form id="updateForm<%=tmp.getNum() %>" class="comment-form update-form" action="comment_update.jsp" method="post">
   						<input type="hidden" name="num" value="<%=tmp.getNum() %>"/>
   						<textarea name="content"><%=tmp.getContent() %></textarea>
   						<button type="submit">수정</button>
   					</form>
   					<%} %>
   				</li>
   			<%} %>	
   		</ul>
   </div>
   <!-- 원글에 댓글 작성할 폼 -->
   <form class="insert-form" action="comment_insert.jsp" method="post">
   		<input type="hidden" name="ref_group" value="<%=num %>" />
   		<input type="hidden" name="target_nick" value="<%=dto.getNick() %>" />
   		<textarea name="content"></textarea>
   		<button type="submit">등록</button>
   </form>
</div>
<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
<script>
	addDeleteListener(".delete-link");
	addUpdateListener(".update-link");
	addUpdateFormListener(".update-form");
	addReplyListener(".reply-link");
	
	function addDeleteListener(sel){
		let deleteLinks=document.querySelectorAll(sel);
		for(let i=0; i<deleteLinks.length; i++){
			deleteLinks[i].addEventListener("click", function(){
				const num=this.getAttribute("data-num")
				const isDelete=confirm("이 댓글을 삭제 하시겠습니까?");
				if(isDelete){
					ajaxPromise("comment_delete.jsp", "post", "num="+num)
					.then(function(response){
						return response.json();
					})
					.then(function(data){
						if(data.isSuccess){
							document.querySelector("#reli"+num).innerText="삭제된 댓글 입니다.";
						}
					});
				}
			});
		}
	}

	function addUpdateListener(sel){
		let updateLinks=document.querySelectorAll(sel);
		for(let i=0; i<updateLinks.length; i++){
			updateLinks[i].addEventListener("click", function(){
				const num=this.getAttribute("data-num");
				document.querySelector("#updateForm"+num).style.display="block";
			});
		}
	}
	
	function addUpdateFormListener(sel){
		let updateForms=document.querySelectorAll(sel);
		for(let i=0; i<updateForms.length; i++){
			updateForms[i].addEventListener("submit", function(e){
				const form=this;
				e.preventDefault();
				ajaxFormPromise(form)
				.then(function(response){
					return response.json();
				})
				.then(function(data){
					if(data.isSuccess){
		                  const num=form.querySelector("input[name=num]").value;
		                  const content=form.querySelector("textarea[name=content]").value;
		                  //수정폼에 입력한 value 값을 pre 요소에도 출력하기 
		                  document.querySelector("#pre"+num).innerText=content;
		                  form.style.display="none";
					}
				});
			});
		}
	}
	
	function addReplyListener(sel){
		let replyLinks=document.querySelectorAll(sel);
		for(let i=0; i<replyLinks.length; i++){
			replyLinks[i].addEventListener("click", function(){
				const num=this.getAttribute("data-num");
				const form=document.querySelector("#reForm"+num);
				let current=this.innerText;
				if(current == "답글"){
					form.style.display="block";
				}else if(current == "취소"){
					form.style.display="none";
				}
			});
		}
	}
</script>
</body>
</html>