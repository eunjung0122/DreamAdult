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
<link
	href="https://fonts.googleapis.com/css2?family=Nerko+One&family=Noto+Sans:wght@700&display=swap"
	rel="stylesheet">
<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}

body {
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 16px;
}

.title-font{
	font-family:'Montserrat', 'Noto Sans KR', sans-serif;
	font-size: 18px;
	font-weight: 700;
}

.nav-item {
	margin: 0 28px;
}

.dropdown svg {
	color: black;
}

#fixedMenuBer {
	height: 73px;
	background: #fff;
	border-bottom: 1px solid #eee;
	display: none;
	padding: 14px 0;
}
</style>
</head>
<body>
	<nav id="menuBer" class="navbar navbar-light navbar-expand-lg title-font" style="">
		<div class="container">
			<a class="navbar-brand" href="<%=request.getContextPath() %>/">
				<img src="${pageContext.request.contextPath}/images/logo2.png" width="21" height="21" />
				Dream Adult 
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav m-auto ">
					<li class="nav-item ms-2"><a
						class="nav-link <%=thisPage.equals("qna") ? "active" : "" %>"
						href="<%=request.getContextPath() %>/qna/list.jsp">Q&A</a></li>
					<li class="nav-item ms-2"><a
						class="nav-link <%=thisPage.equals("file") ? "active" : "" %>"
						href="<%=request.getContextPath() %>/file/list.jsp">자료실</a></li>
					<li class="nav-item ms-2"><a
						class="nav-link <%=thisPage.equals("study") ? "active" : "" %>"
						href="<%=request.getContextPath() %>/study/list.jsp">학습 공부</a></li>
				</ul>
				
				<div class="dropdown" style="padding-right: 40px;">
					<button class="btn dropdown-toggle" type="button"
						id="dropdownMenuButton1" data-bs-toggle="dropdown"
						aria-expanded="false">
						<svg id="Pericon" xmlns="http://www.w3.org/2000/svg" width="16"
							height="16" fill="currentColor" class="bi bi-person-fill"
							viewBox="0 0 16 16">
							<path
								d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
						</svg>
					</button>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
						<%if(id==null){ %>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/users/signup_form.jsp">회원가입</a>
						</li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/users/loginform.jsp">로그인</a>
						</li>
						<%}else{ %>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/users/private/info.jsp">회원정보</a>
						</li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/users/logout.jsp">로그아웃</a>
						</li>
						<%} %>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<nav id="fixedMenuBer" class="navbar navbar-light navbar-expand-lg title-font">
		<div class="container">
			<a class="navbar-brand" href="<%=request.getContextPath()%>/"> 
				<img src="" alt="" /> 오늘의 코린이
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
	</nav>
	<script>
		window.addEventListener("scroll", function() {
			const menuBer = document.querySelector("#menuBer");
			const fixedMenuBer = document.querySelector("#fixedMenuBer");
			if (window.scrollY > 0) {
				menuBer.style.display = "none";
				fixedMenuBer.style.display = "block"
						 
				fixedMenuBer.classList.add("fixed-top");
			} else {
				menuBer.style.display = "block";
				fixedMenuBer.style.display = "none"
				fixedMenuBer.classList.remove("fixed-top");
			}
		});
	</script>

</body>
</html>