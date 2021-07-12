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
<link rel="stylesheet" href="${pageContext.request.contextPath}/include/navStyle.css"/>
<style>
.bd-placeholder-img {
   font-size: 1.125rem;
   text-anchor: middle;
   -webkit-user-select: none;
   -moz-user-select: none;
   user-select: none;
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
	
.subPadding{
	padding-top:7px;
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
         <a class="navbar-brand mbHdLeft" href="<%=request.getContextPath() %>/">
            <img src="${pageContext.request.contextPath}/images/logo2.png" width="21" height="21" />
            Dream Adult 
         </a>
         <button class="navbar-toggler MbNavIcon" type="button"
            data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
         </button>
         <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav m-auto ">
               <li style="" class="nav-item ms-2 mbHdBottom">
               		<a
						class="nav-link <%=thisPage.equals("study") ? "active" : "" %>"

						href="<%=request.getContextPath() %>/study/list.jsp">
						<img class="mbMnImage" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&opt=C72x72"/>
						<span class="mbMnName">개념쌓기</span>
					</a>
			   </li>
               <li class="nav-item ms-2">
               		<a
						class="nav-link <%=thisPage.equals("file") ? "active" : "" %>"
						href="<%=request.getContextPath() %>/file/list.jsp">
						<img class="mbMnImage" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72"/>
						<span class="mbMnName">코드드림</span>
					</a>
			   </li>
               <li class="nav-item ms-2">
               		<a
						class="nav-link <%=thisPage.equals("qna") ? "active" : "" %>"
						href="<%=request.getContextPath() %>/qna/list.jsp">
						<img class="mbMnImage" src="https://www.kakaocorp.com/page/ico_customer.png"/>
						<span class="mbMnName">묻고답하기</span>
					</a>
			   </li>
            </ul>
            <%-- --%>
            <div class="dropdown" style="padding-right: 40px;">
               <button class="btn dropdown-toggle MbDrMem" type="button"
                  id="dropdownMenuButton1" data-bs-toggle="dropdown"
                  aria-expanded="false">
                  <svg id="Pericon" xmlns="http://www.w3.org/2000/svg" width="24"
                     height="24" fill="currentColor" class="bi bi-person-fill"
                     viewBox="0 0 16 16">
                     <path
                        d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
                  </svg>
               </button>
               
               <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                  <%if(id==null){ %>
                  <li><a class="dropdown-item subPadding"
                     href="${pageContext.request.contextPath}/users/signup_form.jsp">회원가입</a>
                  </li>
                  <li><a class="dropdown-item subPadding"
                     href="${pageContext.request.contextPath}/users/loginform.jsp">로그인</a>
                  </li>
                 <%}else{ %>
                  <li><a class="dropdown-item subPadding"
                     href="${pageContext.request.contextPath}/users/private/info.jsp">회원정보</a>
                  </li>
                  <li><a class="dropdown-item subPadding"
                     href="${pageContext.request.contextPath}/users/logout.jsp">로그아웃</a>
                  </li>
                 <%} %>
               </ul>
            </div>
            <%if(id != null){ %>
            	<div class="dropdown" style="padding-right: 40px;">
            		<a class="MbDrBook" href="${pageContext.request.contextPath}/users/private/bookmarked.jsp">
            			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-bookmark-check-fill" viewBox="0 0 16 16">
		                	<path fill-rule="evenodd" d="M2 15.5V2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v13.5a.5.5 0 0 1-.74.439L8 13.069l-5.26 2.87A.5.5 0 0 1 2 15.5zm8.854-9.646a.5.5 0 0 0-.708-.708L7.5 7.793 6.354 6.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3z"/>
		                </svg>
            		</a>     
	            </div>
            <%}%>  
         </div>
      </div>
   </nav>

	<nav id="fixedMenuBer" class="navbar navbar-light navbar-expand-lg title-font">
		<div class="container">
			<a class="navbar-brand" href="<%=request.getContextPath()%>/"> 
				<img src=""/>
				오늘은 코린이
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
		</div>
	</nav>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		$(function(){
			$(".pcMembers").click(function(){
				if($(".pcSubScript").css("display")=="none"){
					$(".pcSubScript").show();
				}
			});
		});
	
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
		
		$(function(){
			$(".pcMembers").click(function(){
				if($(".pcSubScript").css("display")=="none"){
					$(".pcSubScript").show();
				}
			});
		});
	</script>

</body>
</html>