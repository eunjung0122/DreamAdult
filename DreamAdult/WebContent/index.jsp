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
	
	StudyDto dto=new StudyDto();
	dto.setEndRowNum(endRowNum);
	List<StudyDto> studyList=StudyDao.getInstance().getLikeMaxList(dto);
	

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
<title>index.jsp</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<style>
	.btn.btn-custom-dark {
	  display: inline-block;
	  height: 40px;
	  margin-top: 24px;
	  padding: 9px 20px 0;
	  border-radius: 42px;
	  font-size: 14px;
	  line-height: 22px;
	  color: #fff;
	  background-color: #000;
	  vertical-align: top;
	}
	.btn.btn-custom-dark:hover{
		color:#fff;
		background-color: #000;
	}

	.main_page .main_tit{
		margin:60px 0;
	}
	.table-wrap{
		display:flex;
		flex-wrap:wrap;
	}
	.table-row {
		display: flex;
		flex:1;
		padding: 0 0.5vw;
	}
	.column {
		flex: 50%;
		padding: 0 0.5vw; 
	}
	.column .box {
		margin-top: 1.0vw;
		vertical-align: middle;
	    overflow: hidden;
	    position: relative;
	    border-radius: 14px;
	    background:#fff;
	    box-shadow: 4px 12px 30px 6px rgb(0 0 0 / 9%);
	    transition: top .4s ease-in-out;
	}
	.column .box:hover{
		box-shadow: 4px 12px 30px 6px rgb(0 0 0 / 14%);
		transition: top .4s ease-in-out;
	}
	.box.box-l{
		height:600px;
		position: sticky;
		top:60px;
		min-width:500px;
	}
	.box.box-m{
		height:400px;
		min-width:250px;
	}
	.box.box-s{
		height:200px;
		min-width:250px;
	}
	.txt_wrap{
		padding:25px 24px 0;
		box-sizing:border-box;
		display:block;
	}
	.txt_cate:before {
	    position: absolute;
	    top: 0;
	    left: -4px;
	    width: 16px;
	    height: 16px;
	    background: url(data:image/svg+xml;charset=utf-8,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 18 18'%3E%3Cpath d='M0 0c3.003 2.178 4.963 5.706 4.961 9.699V18H18C18 8.059 9.941 0 0 0' fill='%23eee' fill-rule='evenodd'/%3E%3C/svg%3E);
	    content: "";
	}
	.img-wrap{
		overflow:hidden;
	}
	.img-wrap img{
		width:100%;
		display:block;
	}
	.wrap-etc{
		margin:40px 0;
	}
	.wrap-etc .item_etc{
		padding: 0 0.5vw; 
		margin-top:20px;
	}
	.wrap-etc .item_etc>div{
		height:300px;
		border-radius: 14px;
	}
	.wrap-etc .item_etc:first-of-type>div{
		background:#fae100;
	    background-image: url(https://www.daumkakao.com/page/bg_home_service.png);
	    background-size: 160px 160px;
	    background-repeat:no-repeat;
	    background-position:85% 85%;
	}
	.wrap-etc .item_etc:last-of-type>div{
		background:#3c64ff;
   		background-image: url(https://www.daumkakao.com/page/bg_home_recruit.png);
   		background-size: 309px 160px;
   		background-repeat:no-repeat;
   		background-position:85% 85%;
	}
	.card-main-title{
		margin:20px 0 ;
	}
	.card-main-title>strong{
		font-size:1.6rem;
	}
	.etc-tit{
	    font-size: 1.8rem;
	    font-weight: 600;
	    color: #222;
	    line-height: 1.4;
	}
</style>
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
								<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/65636b49017800001.png?type=thumb&opt=C72x72" style="width:36px;" alt="" />
								<span class="txt_cate">가입인사</span>
							</span>
							<a class="card-main-title" href="" style="display:block;">
								<strong class="tit_card">우리가 Dream Adult에서 노는 방법</strong>
							</a>
							<p>#코딩초보 #코린이 #자바 #스터디</p>
						</span>
						<div class="img-wrap">
							<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/news/5ae1aabe017a00001.png?type=thumb&opt=C630x472" alt="" />
						</div>
					</li>
				</ul>
			</div>
			<div class="table-row">
				<ul class="column">
					<li class="box box-m"><a href="study/private/detail.jsp?num=<%=studyList.get(0).getNum()%>">확인</a></li>
					<li class="box box-m"><a href="study/private/detail.jsp?num=<%=studyList.get(2).getNum()%>">확인</a></li>
					<li class="box box-m">1</li>
					<li class="box box-m">1</li>
				</ul>
				<ul class="column">
					<li class="box box-s"><a href="study/private/detail.jsp?num=<%=studyList.get(1).getNum()%>">확인</a></li>
					<li class="box box-m"></li>
					<li class="box box-m"></li>
					<li class="box box-s"><a href=""></a></li>
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