<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//GET 방식 파라미터 url 이라는 이름으로 전달되는 값이 있는지 읽어와 본다.
	String url=request.getParameter("url");
	//만일 넘어오는 값이 없다면
	if(url==null){
		//로그인 후에 index.jsp 페이지로 갈수 있도록 절대 경로를 구성한다.
		String cPath=request.getContextPath();
		url=cPath+"/index.jsp";
	}
	
	//요청과 함께 전달되는 쿠키 정보 얻어내기
	Cookie[] cooks=request.getCookies();
	//쿠키에서 읽어낸 아이디 비밀번호를 저장할 변수 
	String savedId=null;
	String savedPwd=null;
	if(cooks != null){
		//반복문 돌면서 쿠키 객체를 하나씩 참조
		for(Cookie tmp:cooks){
			//쿠키의 키값을 읽어와서
			String key=tmp.getName();
			if(key.equals("savedId")){//저장된 아이디 값이라면 
				savedId=tmp.getValue();
			}else if(key.equals("savedPwd")){//저장된 비밀번호 값이라면
				savedPwd=tmp.getValue();
			}
		}
		
	}
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/login.css" />
</head>
<body class="text-center">
<jsp:include page="../include/navber.jsp"></jsp:include>
<div class="userform-page">
	<div class="container">
		<main class="form-signin">
		  	<form action="login.jsp" method="post">
		  		<svg id="ryan" viewBox="0 0 120 120" xmlns="http://www.w3.org/2000/svg">
		            <path d="M0,150 C0,65 120,65 120,150" fill="#e0a243" stroke="#000" stroke-width="2.5" />
		            <g class="ears">
		                <path d="M46,32 L46,30 C46,16 26,16 26,30 L26,32" fill="#e0a243" stroke="#000" stroke-width="2.5" stroke-linecap="round" transform="rotate(-10,38,24)" />
		                <path d="M74,32 L74,30 C74,16 94,16 94,30 L94,32" fill="#e0a243" stroke="#000" stroke-width="2.5" stroke-linecap="round" transform="rotate(10,82,24)" />
		            </g>
		            <circle cx="60" cy="60" r="40" fill="#e0a243" stroke="#000" stroke-width="2.5" />
		            <g class="eyes">
		                <!-- left eye and eyebrow-->
		                <line x1="37" x2="50" y1="46" y2="46" stroke="#000" stroke-width="3" stroke-linecap="round" />
		                <circle cx="44" cy="55" r="3" fill="#000" />
		                <!-- right eye and eyebrow -->
		                <line x1="70" x2="83" y1="46" y2="46" stroke="#000" stroke-width="3" stroke-linecap="round" />
		                <circle cx="76" cy="55" r="3" fill="#000" />
		            </g>
		            <g class="muzzle">
		                <path d="M60,66 C58.5,61 49,63 49,69 C49,75 58,77 60,71 M60,66 C61.5,61 71,63 71,69 C71,75 62,77 60,71" fill="#fff" />
		                <path d="M60,66 C58.5,61 49,63 49,69 C49,75 58,77 60,71 M60,66 C61.5,61 71,63 71,69 C71,75 62,77 60,71" fill="#fff" stroke="#000" stroke-width="2.5" stroke-linejoin="round" stroke-linecap="round" />
		                <polygon points="59,63.5,60,63.4,61,63.5,60,65" fill="#000" stroke="#000" stroke-width="5" stroke-linejoin="round" />
		            </g>
		            <path d="M40,105 C10,140 110,140 80,105 L80,105 L70,111 L60,105 L50,111 L40,105" fill="#fff" />
		        </svg>
		  		<input type="hidden" name="url" value="<%=url %>" />
			    <%if(savedId == null){ %>
				    <div class="form-floating mb-3">
			      		<input type="text" name="id" class="form-control" id="id" placeholder="아이디 입력...">
			      		<label for="id">아이디</label>
				    </div>
				    <div class="form-floating mb-3">
				    	<input type="password" name="pwd" class="form-control" id="pwd" placeholder="비밀번호 입력...">
				      	<label for="pwd">비밀번호</label>
				    </div>
				    <div class="checkbox mb-3">
				     	<label>
				        	<input type="checkbox" name="isSave" value="yes"> 로그인 정보 저장
				      	</label>
				    </div>
			    <%}else{ %>
			    	<div class="form-floating mb-3">
			      		<input value="<%=savedId %>" type="text" name="id" class="form-control" id="id" placeholder="아이디 입력...">
			      		<label for="id">아이디</label>
					</div>
				    <div class="form-floating mb-3">
				    	<input value="<%=savedPwd %>"  type="password" name="pwd" class="form-control" id="pwd" placeholder="비밀번호 입력...">
				      	<label for="pwd">비밀번호</label>
				    </div>
				    <div class="checkbox mb-3">
				     	<label>
				        	<input type="checkbox" name="isSave" value="yes" checked> 로그인 정보 저장
				      	</label>
				    </div>
			    <%} %>  
			    <button class="w-100 btn btn-l btn-max btn-custom-dark" type="submit">로그인</button>
			    <p class="mt-5 mb-3 text-muted">&copy; 2021-DreamAdult</p>
		  	</form>
		</main>
	</div>
</div>
<script src="<%=request.getContextPath()%>/js/ryon.js"></script>
</body>
</html>