<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="test.study.dao.StudyDao"%>
<%@page import="java.util.List"%>
<%@page import="test.study.dto.StudyDto"%>
<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.study.dao.StudyCommentDao"%>
<%@page import="test.file.dao.FileCommentDao"%>
<%@page import="test.qna.dao.QnACommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id=(String)session.getAttribute("id");

 
	final int PAGE_ROW_COUNT=3;
	int pageNum=1;
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	StudyDto dto = new StudyDto();
	dto.setEndRowNum(endRowNum);
	List<StudyDto> studyList=StudyDao.getInstance().getLikeMaxList(dto);
	
	FileDto filedto = new FileDto();
	List<FileDto> fileList = FileDao.getInstance().getLikeMaxList(filedto);

	boolean isUpgrade=false;
	
	if(id!=null){
		int qnaComment=QnACommentDao.getInstance().myCount(id);
		int fileComment=FileCommentDao.getInstance().myCount(id);
		int studyComment=StudyCommentDao.getInstance().myCount(id);
		int commentCount=qnaComment+fileComment+studyComment;
		
		String grade=UsersDao.getInstance().getGrade(id);
		
		if(grade.equals("child")&&commentCount>=5&&commentCount<20){
			isUpgrade=UsersDao.getInstance().upgradeStudent(id);
		}else if(!grade.equals("adult")&&commentCount>=20){
			isUpgrade=UsersDao.getInstance().upgradeAdult(id);
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<link rel="stylesheet" href="css/main.css" />
</head>
<body>
<jsp:include page="include/navber.jsp"></jsp:include>
<div class="main_page container">
	<h1 class="main_tit">
		오늘의 코린이<br>
		희망차게 하루를 시작해보아요!
		<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-brightness-high" viewBox="0 0 16 16">
		  <path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
		</svg>
	</h1>
	<div class="container">
		<div class="table-wrap">
			<div class="table-row" >
				<ul class="column">
					<li class="box box-l">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/65636b49017800001.png?type=thumb&opt=C72x72"/>
								<span class="txt_cate">가입인사</span>
							</span>
							<a class="card-main-tit card-l" href="" style="display:block;">
								<strong class="tit_card">우리가 Dream Adult에서 노는 방법</strong>
							</a>
							<p class="card-tag">#코딩초보 #코린이 #자바 #스터디</p>
						</span>
						<div class="img-wrap">
							<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/news/5ae1aabe017a00001.png?type=thumb&opt=C630x472"/>
						</div>
					</li>
				</ul>
			</div>
			<div class="table-row">
				<ul class="column">
					<li class="box box-m">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72"/>
								<span class="txt_cate">코드공유</span>	
							</span>
							<a class="card-main-tit" href="file/private/detail.jsp?num=<%=fileList.get(0).getNum()%>">
								<strong class="tit_card"><%=fileList.get(0).getTitle()%></strong>
							</a>
							<p>
								<span><%=fileList.get(0).getNick()%></span>
								<span><%=fileList.get(0).getRegdate()%></span>
							</p>
						</span>
						<div class="img-wrap">
							<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/news/79590191017a00001.jpg?type=thumb&opt=C630x472"/>
						</div>
					</li>
					<li class="box box-m">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&opt=C72x72"/>
								<span class="txt_cate">학습공부</span>
							</span>
							<a href="study/private/detail.jsp?num=<%=studyList.get(2).getNum()%>">확인</a>
						</span>
					</li>
					<li class="box box-m">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://www.kakaocorp.com/page/ico_customer.png"/>
								<span class="txt_cate">QnA</span>
							</span>
							1
						</span>
					<li class="box box-m">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72"/>
								<span class="txt_cate">코드공유</span>
								
							</span>
							<a class="card-main-tit" href="file/private/detail.jsp?num=<%=fileList.get(1).getNum()%>">
								<strong class="tit_card"><%=fileList.get(1).getTitle()%></strong>
							</a>
							<p>
								<span><%=fileList.get(1).getNick()%></span>
								<span><%=fileList.get(1).getRegdate()%></span>
							</p>
						</span>
						<div class="img-wrap" style="background:#f77028; height:210px;"></div>
					</li>
				</ul>
				<ul class="column">
					<li class="box box-s">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&opt=C72x72"/>
								<span class="txt_cate">학습공부</span>
							</span>
							<a href="study/private/detail.jsp?num=<%=studyList.get(1).getNum()%>">확인</a>
						</span>
					</li>
					<li class="box box-m">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://www.kakaocorp.com/page/ico_customer.png"/>
								<span class="txt_cate">QnA</span>
							</span>
						</span>
					</li>
					<li class="box box-m">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&opt=C72x72"/>
								<span class="txt_cate">학습공부</span>
							</span>
							<a href="study/private/detail.jsp?num=<%=studyList.get(0).getNum()%>">확인</a>
						</span>
					</li>
					<li class="box box-m">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72"/>
								<span class="txt_cate">코드공유</span>
							</span>
							<a class="card-main-tit" href="file/private/detail.jsp?num=<%=fileList.get(2).getNum()%>">
								<strong class="tit_card"><%=fileList.get(2).getTitle()%></strong>
							</a>
							<p>
								<span><%=fileList.get(2).getNick()%></span>
								<span><%=fileList.get(2).getRegdate()%></span>
							</p>
						</span>
						<div class="img-wrap" style="background:#801ee3; height:210px;"></div>
					</li>
					<li class="box box-s">
						<span class="txt_wrap">
							<span class="info_cate">
								<img src="https://www.kakaocorp.com/page/ico_customer.png" style="width:36px;" alt="" />
								<span class="txt_cate">QnA</span>
							</span>
						</span>
					</li>
				</ul>
			</div>
		</div>
		<div class="wrap-etc row">
			<div class="item_etc col-12 col-lg-6" >
				<div>
					<span class="txt_wrap">
						<h4 class="etc-tit">
							사람과 기술로 일상을 돕는<br>
							코린이 게시판을 볼려면?
						</h4>
						<a class="btn btn-custom-dark" href="${pageContext.request.contextPath}/users/loginform.jsp">
						로그인 하러가기
						<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/>
						</svg>
						</a>
					</span>
				</div>
			</div>
			<div class="item_etc col-12 col-lg-6">
				<div>
					<span class="txt_wrap">
						<h4 class="etc-tit">
							항상 발전하는 코린이와<br>
							함께 하고싶다면?
						</h4>
						<a class="btn btn-custom-dark" href="${pageContext.request.contextPath}/users/signup_form.jsp">
						회원가입 하러가기
						<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">
						  <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/>
						</svg>
						</a>
					</span>
				</div>
			</div>
		</div>
	</div>

	<a class="link-top" href="">
		<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-arrow-up-short" viewBox="0 0 16 16">
		  <path fill-rule="evenodd" d="M8 12a.5.5 0 0 0 .5-.5V5.707l2.146 2.147a.5.5 0 0 0 .708-.708l-3-3a.5.5 0 0 0-.708 0l-3 3a.5.5 0 1 0 .708.708L7.5 5.707V11.5a.5.5 0 0 0 .5.5z"/>
		</svg>
	</a>
</div>
<footer style="height:400px; border-top:1px solid #ddd;">
	<div class="container">
		<p style="padding-top:60px;">© dream adult. All rights reserved.</p>
	</div>
</footer>
<%
	Cookie[] cookies=request.getCookies();
	
	boolean isPopup=true;
	if(cookies != null){
		for(Cookie tmp : cookies){
			if(tmp.getName().equals("isPopup")){
				isPopup=false;
			}
		}
	}
%>
<script>
<%if(isPopup){ %>
	window.open("popup.jsp", "웰컴팝업창", "width=500,height=400,top=100,left=100");
<%} %>
<%if(isUpgrade){%>
	window.open("grade_popup.jsp", "등급 업 팝업창", "width=600,height=450,top=100,left=600");
<%}%>
</script>
</body>
</html>