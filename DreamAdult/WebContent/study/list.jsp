<%@page import="test.study.dao.StudyCommentDao"%>
<%@page import="test.study.dto.StudyCommentDto"%>
<%@page import="java.util.List"%>
<%@page import="test.study.dao.StudyDao"%>
<%@page import="test.study.dto.StudyDto"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=5;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=5;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(strPageNum != null){
	   //숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
	   pageNum=Integer.parseInt(strPageNum);
	}
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	String keyword=request.getParameter("keyword");
	String condition=request.getParameter("condition");
	String category=request.getParameter("category");
	
	if(keyword==null){
		keyword="";
		condition="";
	}
	if(category==null){
		category="whole";
		
	}
	
	String encodedK=URLEncoder.encode(keyword);
	
	StudyDto dto=new StudyDto();
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	List<StudyDto> list=null;
	
	int totalRow=0;
	
	if(keyword.equals("")&&category.equals("whole")){
		list=StudyDao.getInstance().getList(dto);
		totalRow=StudyDao.getInstance().getCount();
	}else if(keyword.equals("")&&!category.equals("whole")){
		dto.setCategory(category);
		list=StudyDao.getInstance().getListC(dto);
		totalRow=StudyDao.getInstance().getCountC(dto);
	}else if(category.equals("whole")&&!keyword.equals("")){
		if(condition.equals("title")){
			dto.setTitle(keyword);
			list=StudyDao.getInstance().getListT(dto);
			totalRow=StudyDao.getInstance().getCountT(dto);
		}else if(condition.equals("nick")){
			dto.setNick(keyword);
			list=StudyDao.getInstance().getListN(dto);
			totalRow=StudyDao.getInstance().getCountN(dto);
		}else if(condition.equals("title_content")){
			dto.setTitle(keyword);
			dto.setContent(keyword);
			list=StudyDao.getInstance().getListTC(dto);
			totalRow=StudyDao.getInstance().getCountTC(dto);
		}
	}else if(!category.equals("whole")&&!keyword.equals("")){
		if(condition.equals("title")){
			dto.setCategory(category);
			dto.setTitle(keyword);
			list=StudyDao.getInstance().getListTCa(dto);
			totalRow=StudyDao.getInstance().getCountTCa(dto);
		}else if(condition.equals("nick")){
			dto.setCategory(category);
			dto.setNick(keyword);
			list=StudyDao.getInstance().getListNCa(dto);
			totalRow=StudyDao.getInstance().getCountNCa(dto);
		}else if(condition.equals("title_content")){
			dto.setCategory(category);
			dto.setTitle(keyword);
			dto.setContent(keyword);
			list=StudyDao.getInstance().getListTCCa(dto);
			totalRow=StudyDao.getInstance().getCountTCCa(dto);
		}
	}
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	   

	//전체 페이지의 갯수
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 전체 페이지 갯수보다 크다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
	   endPageNum=totalPageCount; //보정해 준다.
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" />
</head>
<body>
<jsp:include page="../include/navber.jsp">
   <jsp:param value="study" name="thisPage"/>
</jsp:include>
<div class="sub_page container">
	<h1 class="main_tit">
		<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/category/322d2261017a00001.png?type=thumb&opt=C72x72">
		<span>학습공부</span>
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
			<a href="<%=request.getContextPath()%>/study/private/insertform.jsp" class="btn btn-s btn-custom-dark">새글 작성</a>
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
		<%for(StudyDto tmp:list){%>
         <tr>
            <td><%=tmp.getNum() %></td>
            <td><%=tmp.getCategory() %></td>
            <td style="text-align:left;">
               <a class="subject" href="private/detail.jsp?num=<%=tmp.getNum()%>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>"><%=tmp.getTitle()%>
               <span> [<%=StudyCommentDao.getInstance().replyCount(tmp.getNum()) %>]</span>
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