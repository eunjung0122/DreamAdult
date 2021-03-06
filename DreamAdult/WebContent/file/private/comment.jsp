<%@page import="test.file.dto.FileDto"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dao.FileCommentDao"%>
<%@page import="java.util.List"%>
<%@page import="test.file.dto.FileCommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));   
	String id=(String)session.getAttribute("id");
	FileDto dto=FileDao.getInstance().getData(num);
	
	
	final int PAGE_ROW_COUNT = 10;
	int pageNum = 1;
	
	int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
	int endRowNum = pageNum * PAGE_ROW_COUNT;
	
	//원글의 글번호를 이용해서 해당글에 달린 댓글목록을 얻어온다.
	FileCommentDto commentDto = new FileCommentDto();
	commentDto.setRef_group(num);
	
	
	commentDto.setStartRowNum(startRowNum);
	commentDto.setEndRowNum(endRowNum);
	List<FileCommentDto> commentList = FileCommentDao.getInstance().getList(commentDto);
	
	int totalRow = FileCommentDao.getInstance().getCount(num);
	int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<style>
.content{
      border: 1px dotted gray;
   }
   
   /* 댓글 프로필 이미지를 작은 원형으로 만든다. */
   .profile-image{
      width: 50px;
      height: 50px;
      border: 1px solid #cecece;
      border-radius: 50%;
   }
   /* ul 요소의 기본 스타일 제거 */
   .comments ul{
      padding: 0;
      margin: 0;
      list-style-type: none;
   }
   .comments dt{
      margin-top: 5px;
   }
   .comments dd{
      margin-left: 50px;
   }
   .comment-form textarea, .comment-form button{
      float: left;
   }
   .comments li{
      clear: left;
   }
   .comments ul li{
      border-top: 1px solid #888;
   }
   .comment-form textarea{
      width: 84%;
      height: 100px;
   }
   .comment-form button{
      width: 14%;
      height: 100px;
   }
   /* 댓글에 댓글을 다는 폼과 수정폼은 일단 숨긴다. */
   .comments .comment-form{
      display: none;
   }
   /* .reply_icon 을 li 요소를 기준으로 배치 하기 */
   .comments li{
      position: relative;
   }
   .comments .reply-icon{
      position: absolute;
      top: 1em;
      left: 1em;
      color: red;
   }
   pre {
     display: block;
     padding: 9.5px;
     margin: 0 0 10px;
     font-size: 13px;
     line-height: 1.42857143;
     color: #333333;
     word-break: break-all;
     word-wrap: break-word;
     background-color: #f5f5f5;
     border: 1px solid #ccc;
     border-radius: 4px;
   }      
   .loader{
   		/*로딩 이미지를 가운데 정렬*/
   		text-align:center;
   		/*일단 숨겨 놓기*/
   		display:none;
   }
   .loader svg{
   		animation: rotateAni 1s ease-out infinite;
   }
   
   @keyframes rotateAni{
   		0%{
   			transform: rotate(0deg);
   		}
   		100%{
   			transform: rotate(360deg);
   		}
   }
   a{
   	 text-decoration:none;
   }	  
</style>
</head>
<body>
<div class="container">
	<div class="comments">
			<ul>
				<%for(FileCommentDto tmp: commentList){ %>
					<%if(tmp.getDeleted().equals("yes")){ %>
						<li>삭제된 댓글 입니다</li>
					<%continue; } %>
					<%if(tmp.getNum() == tmp.getComment_group()){ %>
					<li id="reli<%=tmp.getNum()%>" class="page-<%=pageNum%>">
					<%}else{ %>
					<li id="reli<%=tmp.getNum()%>" class="page-<%=pageNum%>" style="padding-left: 50px;">
						<svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
	                    	<path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
	               		</svg>
					<%} %>
						<dl>
							<dt>
								<%if(tmp.getProfile() == null){%>
								<svg class="profile-image" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
		                          	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
		                          	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
		                     	</svg>
								<%}else{ %>
								<img class="profile-image" src="${pageContext.request.contextPath}<%=tmp.getProfile()%>"/>
								<%} %>
									<span><%=tmp.getWriter() %></span>
								<%if(tmp.getNum() != tmp.getComment_group()){ %>
									@<i><%=tmp.getTarget_nick() %></i>
								<%} %>
									<span><%=tmp.getRegdate() %></span>
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
						<form id="reForm<%=tmp.getNum() %>" class="animate__animated comment-form re-insert-form" action="comment_insert.jsp" method="post">
	   						<input type="hidden" name="ref_group" value="<%=dto.getNum()%>"/>
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
			</ul>
		</div>
		<div class="loader">
		   	<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
			  <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
			</svg>
	   </div>
		<form class="comment-form insert-form" action="comment_insert.jsp" method="post">
			<input type="hidden" name="ref_group" value="<%=num %>" />
			<input type="hidden" name="target_nick" value="<%=dto.getNick() %>" />
			
			<textarea name="content"></textarea>
			<button type="submit">등록</button>
		</form>
	</div>
</div>
	<script src="${pageContext.request.contextPath}/js/gura_util.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script>
	addReplyListener(".reply-link");
	addUpdateListener(".update-link");
	addUpdateFormListener(".update-form");
	addDeleteListener(".delete-link");
	
	
	
	let currentPage=1;
	let lastPage=<%=totalPageCount%>;
	let isLoading=false;
	
	window.addEventListener("scroll",function(){
		const isBottom=window.innerHeight + window.scrollY  >= document.body.offsetHeight;
		let isLast=currentPage==lastPage;
		if(isBottom&&!isLoading&&!isLast){
			document.querySelector(".loader").style.display="block";
			isLoading=true;
			currentPage++;
			
			ajaxPromise("ajax_comment_list.jsp","get",
					"pageNum="+currentPage+"&num=<%=num%>")
			.then(function(response){
				return response.text();
			})
			.then(function(data){
	            document.querySelector(".comments ul").insertAdjacentHTML("beforeend", data);
	            
	            isLoading=false;
	            
	            addUpdateListener(".page-"+currentPage+" .update-link");
	            addDeleteListener(".page-"+currentPage+" .delete-link");
	            addReplyListener(".page-"+currentPage+" .reply-link");
	            addUpdateFormListener(".page-"+currentPage+" .update-form");
	       	
	            document.querySelector(".loader").style.display="none";
	         });
		}
		
	});
	
		
	function addReplyListener(sel){
		let replyLinks=document.querySelectorAll(sel);
		for(let i=0; i<replyLinks.length; i++){
			replyLinks[i].addEventListener("click",function(){
				const num=this.getAttribute("data-num");
				const form=document.querySelector("#reForm"+num);
				let current=this.innerText;
				if(current=="답글"){
					form.style.display="block";
					form.classList.add("animate__flash");
					this.innerText="취소";
					form.addEventListener("animationend",function(){
						form.classList.remove("animate__flash");
					},{once:true});
				}else if(current=="취소"){
					form.classList.add("animate__fadeOut");
		            this.innerText="답글";
					form.addEventListener("animationend", function(){
		                form.classList.remove("animate__fadeOut");
		                form.style.display="none";
		            },{once:true});
				}
			});
		}
		
	}
	
	function addUpdateListener(sel){
		let updateLinks=document.querySelectorAll(sel);
		for(let i=0; i<updateLinks.length; i++){
			updateLinks[i].addEventListener("click",function(){
				const num=this.getAttribute("data-num");
				const form=document.querySelector("#updateForm"+num);
				let current=this.innerText;
				if(current=="수정"){
					form.style.display="block";
					this.innerText="취소";
				}else if(current=="취소"){
		            this.innerText="수정";
		            form.style.display="none";
				}
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
		                document.querySelector("#pre"+num).innerText=content;
		               	form.style.display="none";
					}
				});
			});
		}
	}
	
	   function addDeleteListener(sel){
		      let deleteLinks=document.querySelectorAll(sel);
		      for(let i=0; i<deleteLinks.length; i++){
		         deleteLinks[i].addEventListener("click", function(){
		               const num=this.getAttribute("data-num"); 
		               Swal.fire({
		        		   text: '댓글을 삭제하시겠습니까?',
		        		   icon: 'warning',
		        		   showDenyButton: true,
		        		   showCancelButton: true,
		        		   confirmButtonColor: '#000',
		        		   cancelButtonColor: '#f77028',
		        		   confirmButtonText: `Yes`,
		        		   denyButtonText: `Cancel`,
		        		 }).then((result) => {
		        		   if (result.isConfirmed) {
		        			   ajaxPromise("comment_delete.jsp", "post", "num="+num)
		 	                  .then(function(response){
		 	                     return response.json();
		 	                  })
		 	                  .then(function(data){
		 	                     if(data.isSuccess){
		 	                        document.querySelector("#reli"+num).innerText="삭제된 댓글입니다.";
		 	                     }
		 	                  });	        			 	        			   
		        		   } else if (result.isDenied) {
		        			   location.href="${pageContext.request.contextPath}/file/private/detail.jsp?num=<%=dto.getNum()%>";
		        		   }
		        		 })
		            });
		      }
		   } 
</script>
<jsp:include page="../../include/footer.jsp"></jsp:include>
</body>
</html>