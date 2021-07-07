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
<title>list.jsp</title>

<style>
	.page-ui a{
      text-decoration: none;
      color: #000;
   }
   
   .page-ui a:hover{
      text-decoration: underline;
   }
   
   .page-ui a.active{
      color: red;
      font-weight: bold;
   }
   .page-ui ul{
      list-style-type: none;
      padding: 0;
   }
   
   .page-ui ul > li{
      float: left;
      padding: 5px;
   }
</style>
</head>
<body>
<jsp:include page="../include/navber.jsp">
   <jsp:param value="file" name="thisPage"/>
</jsp:include>
<div class="container">
    <a href="<%=request.getContextPath() %>/file/private/uploadform.jsp">새글 작성</a>
		<table>
	         <thead>
	            <tr>
	               <th>글번호</th>
	               <th>카테고리</th>
	               <th>제목</th>
	               <th>작성자</th>
	               <th>조회수</th>
	               <th>등록일</th>
	            </tr>
	         </thead>
	         <tbody>
	            <%for(FileDto tmp:list){%>
	                  <tr>
	                     <td><%=tmp.getNum() %></td>
	                     <td><%=tmp.getCategory() %></td>
	                     <td>
              				 <a href="private/detail.jsp?num=<%=tmp.getNum()%>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>"><%=tmp.getTitle()%></a>
            				[<%=FileCommentDao.getInstance().replyCount(tmp.getNum()) %>]
           				 </td>
	                     <td><%=tmp.getNick() %></td>
	                     <td><%=tmp.getViewCount() %></td>
	                     <td><%=tmp.getRegdate() %></td>
	                  </tr>
	               <%} %>
	         </tbody>
	      </table>	
	<div class="page-ui clearfix">
      <ul>
         <%if(startPageNum != 1){ %>
            <li>
               <a href="list.jsp?pageNum=<%=startPageNum-1 %>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>">Prev</a>
            </li>   
         <%} %>
         
         <%for(int i=startPageNum; i<=endPageNum ; i++){ %>
            <li>
               <%if(pageNum == i){ %>
                  <a class="active" href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>"><%=i %></a>
               <%}else{ %>
                  <a href="list.jsp?pageNum=<%=i %>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>"><%=i %></a>
               <%} %>
            </li>   
         <%} %>
         <%if(endPageNum < totalPageCount){ %>
            <li>
               <a href="list.jsp?pageNum=<%=endPageNum+1 %>&condition=<%=condition %>&keyword=<%=encodedK %>&category=<%=category%>" >Next</a>
            </li>
         <%} %>
      </ul>
   </div>
   
   <div style="clear:both;"></div>
   
   <form action="list.jsp" method="get" id="myForm">
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
   		
   		<button type="submit">검색</button>
   </form>
   <%if(id!=null) {%>
   		<a href="private/myPage.jsp">내가 쓴 글 보기</a>
   <%} %>
   
   <%if(!condition.equals("")) {%>
		<p>
			<strong><%=totalRow %></strong>개의 글이 검색 되었습니다. 
		</p>
   <%} %>
	
</div>
</body>
</html>