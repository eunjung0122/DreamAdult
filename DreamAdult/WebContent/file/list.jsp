<%@page import="test.file.dao.FileCommentDao"%>
<%@page import="test.file.dto.FileCommentDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="java.util.List"%>
<%@page import="test.file.dao.FileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	final int PAGE_ROW_COUNT = 5;
	final int PAGE_DISPLAY_COUNT = 5;
	
	int pageNum = 1;
	String strPageNum = request.getParameter("pageNum");
	if (strPageNum != null)
		pageNum = Integer.parseInt(strPageNum);
	
	int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
	int endRowNum = pageNum * PAGE_ROW_COUNT;


	FileDto dto = new FileDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	FileDao dao = FileDao.getInstance();
	
	List<FileDto> list = null;
	int totalRow = 0;
	
	String keyword = request.getParameter("keyword");
	String condition = request.getParameter("condition");
	String category=request.getParameter("category");
	
	if(keyword==null){
		keyword="";
		condition="";
	}
	if(category==null){
		category="whole";
		
	}
	//특수기호를 인코딩한 키워드를 미리 준비한다
	String encodedK = URLEncoder.encode(keyword);
	
	if(keyword.equals("")&&category.equals("whole")){
		list = dao.getList(dto);
		totalRow = dao.getCount();
		
	}else if(keyword.equals("")&&!category.equals("whole")){
		dto.setCategory(category);
		list = dao.getListC(dto);
		totalRow = dao.getCountC(dto);
		
	}else if(category.equals("whole")&&!keyword.equals("")){
		if(condition.equals("title")){
			dto.setTitle(keyword);
			list= dao.getListT(dto);
			totalRow = dao.getCountT(dto);
			
		}else if(condition.equals("nick")){
			dto.setNick(keyword);
			list = dao.getListN(dto);
			totalRow = dao.getCountN(dto);
			
		}else if(condition.equals("title_content")){
			dto.setTitle(keyword);
			dto.setContent(keyword);
			list = dao.getListTC(dto);
			totalRow = dao.getCountTC(dto);
		}
	}else if(!category.equals("whole")&&!keyword.equals("")){
		if(condition.equals("title")){
			dto.setCategory(category);
			dto.setTitle(keyword);
			list = dao.getListTCa(dto);
			totalRow = dao.getCountTCa(dto);
			
		}else if(condition.equals("nick")){
			dto.setCategory(category);
			dto.setNick(keyword);
			list = dao.getListNCa(dto);
			totalRow = dao.getCountNCa(dto);
			
		}else if(condition.equals("title_content")){
			dto.setCategory(category);
			dto.setTitle(keyword);
			dto.setContent(keyword);
			list = dao.getListTCCa(dto);
			totalRow = dao.getCountTCCa(dto);
			
		}
	}

	
	int startPageNum = 1 + ((pageNum - 1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
	int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;
	
	int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
	if (endPageNum > totalPageCount)
		endPageNum = totalPageCount;
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" />
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
</head>
<body>
<jsp:include page="../include/navber.jsp">
   <jsp:param value="file" name="thisPage"/>
</jsp:include>

<div class="sub_page container">
	<h1 class="main_tit">
		<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72">
		<span>코드공유</span>
	</h1>

   <form action="list.jsp" method="get" id="myForm" class="search-bar">

   		<select name="category" id="category">
   			<option value="whole" <%=category.equals("whole") ? "selected" : ""%>>전체 분류</option>
   			<option value="java" <%=category.equals("java") ? "selected" : ""%>>java</option>
   			<option value="javascript" <%=category.equals("javascript") ? "selected" : ""%>>javascript</option>
   			<option value="jsp" <%=category.equals("jsp") ? "selected" : ""%>>jsp</option>
   		</select>
   		
   		<select name="condition" id="condition" onchange="categoryChange(this)">
   			<option value="title_content" <%=condition.equals("title_content") ? "selected" : ""%>>제목 내용</option>
   			<option value="title" <%=condition.equals("title") ? "selected" : ""%>>제목</option>
		    <option value="nick" <%=condition.equals("nick") ? "selected" : ""%>>작성자</option>
		</select>
   		<input type="text" id="keyword" name="keyword" placeholder="검색어..." value="<%=keyword%>" />
   		<button type="submit">
   			<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
			  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
			</svg>
   		</button>
   </form>

	<div class="table-info">
		<p><strong><%=totalRow %></strong>개의 글이 검색 되었습니다. </p>
		<div>
			<a href="<%=request.getContextPath()%>/file/private/uploadform.jsp" class="btn btn-s btn-custom-dark">새글 작성</a>
			<%if(id!=null) {%>
		  		<a href="private/myPage.jsp" class="btn btn-s btn-custom-gray">내가 쓴 글 보기</a>
		 	<%} %>
	 	</div>
	</div>
    
		<table class="table table-hover">
			<colgroup>
				<col width="100px" />
				<col width="200px" />
				<col width="auto" style="text-align: left;" />
				<col width="160px" />
				<col width="200px" />
				<col width="80px" />
			</colgroup>
			<thead>
	            <tr>
					<th>No</th>
					<th>카테고리</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
	         </thead>
	         <tbody>
	            <%for(FileDto tmp:list){%>
	                  <tr>
	                     <td><%=tmp.getNum() %></td>
	                     <td><%=tmp.getCategory() %></td>
	                     <td style="text-align:left;">
              				 <a class="subject" href="private/detail.jsp?num=<%=tmp.getNum()%>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>"><%=tmp.getTitle()%>
              				 <span>[<%=FileCommentDao.getInstance().replyCount(tmp.getNum()) %>]</span>
              				 </a>
           				 </td>
	                     <td><%=tmp.getNick() %></td>
	                     <td><%=tmp.getRegdate() %></td>
	                     <td><%=tmp.getViewCount() %></td>
	                  </tr>
	               <%} %>
	         </tbody>
	      </table>	
		<nav class="pagination-wrap" aria-label="Page navigation example">
		  <ul class="pagination">
		  	<%if(startPageNum != 1){ %>
		    <li class="page-item">
		      <a class="page-link" href="list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    <%} %>
		    <%for(int i=startPageNum; i<=endPageNum ; i++){ %>
		    	<%if(pageNum == i){ %>
	            <li class="page-item active">
	                <a class=" page-link" href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>"><%=i %></a>
	            </li>   
	            <%}else{ %>
	            <li class="page-item">
	              <a class="page-link" href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>"><%=i %></a>
	            </li>   
	            <%} %>
	         <%} %>
		    <%if(endPageNum < totalPageCount){ %>
	            <li class="page-item">
	               <a class="page-link" href="list.jsp?pageNum=<%=endPageNum+1 %>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>" aria-label="Next">
	               	<span aria-hidden="true">&raquo;</span>
	               </a>
	            </li>
	         <%} %>
		  </ul>
		</nav>
	</div>


<script>
	let commentLinks=document.querySelectorAll(".comment-link");
	for(i=0; i<commentLinks.length; i++){
		commentLinks[i].addEventListener("click",function(){
			const num=this.getAttribute("data-num");
			window.open("private/comment.jsp?num="+num, "댓글목록", "width=900,height=600,top=300,left=500");
		});
	}
</script>

</body>
</html>