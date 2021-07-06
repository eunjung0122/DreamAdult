<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String thisPage=request.getParameter("thisPage");
	if(thisPage==null){
	   thisPage="";
	}
	
	String id=(String)session.getAttribute("id");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>navber.jsp</title>
<jsp:include page="resource.jsp"></jsp:include>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nerko+One&family=Noto+Sans:wght@700&display=swap" rel="stylesheet">
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      
    </style>
</head>
<body>
<nav class="navbar navbar-expand-md">
  <div class="container">
    <a class="navbar-brand" href="<%=request.getContextPath() %>" style="font-family: 'Nerko One', cursive; font-weight:400; font-size:30px; color:black;">Dream Adult</a>
    <button class="navbar-toggler" type="button">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav me-auto mb-2 mb-md-0 ms-auto">
        <li class="nav-item">
          <a class="nav-link ms-5 <%=thisPage.equals("qna") ? "active" : "" %>" href="<%=request.getContextPath() %>/qna/list.jsp" style="color:black;">Q&A</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ms-5 <%=thisPage.equals("file") ? "active" : "" %>" href="<%=request.getContextPath() %>/file/list.jsp" style="color:black;">자료실</a>
        </li>
        <li class="nav-item">
          <a class="nav-link ms-5 <%=thisPage.equals("study") ? "active" : "" %>" href="<%=request.getContextPath() %>/study/list.jsp" style="color:black;">학습 공부</a>
        </li>
      </ul>
      <div class="dropdown">
		  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
		  	<svg id="Pericon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
			  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
			</svg>
		  </button>
		  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
		  <%if(id==null){ %>
      	  	<li>
      			<a class="dropdown-item" href="${pageContext.request.contextPath}/users/signup_form.jsp">회원가입</a>	
      		</li>
      		<li>
      			<a class="dropdown-item" href="${pageContext.request.contextPath}/users/loginform.jsp">로그인</a>
      		</li>
		  <%}else{ %>
	  		<li>
			    <a class="dropdown-item" href="${pageContext.request.contextPath}/users/private/info.jsp">회원정보</a>
	  		</li>
	  		<li>
	  			<a class="dropdown-item" href="${pageContext.request.contextPath}/users/logout.jsp">로그아웃</a>
	  		</li>
		  <%} %>
	  </div>
    </div>
  </div>
</nav>
</body>
</html>