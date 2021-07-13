<%@page import="test.study.dao.StudyLikeDao"%>
<%@page import="test.qna.dao.QnALikeDao"%>
<%@page import="test.file.dao.FileLikeDao"%>
<%@page import="test.qna.dao.QnADao"%>
<%@page import="test.qna.dto.QnADto"%>
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
	
	StudyDto studydto = new StudyDto();
	studydto.setEndRowNum(endRowNum);
	List<StudyDto> studyList=StudyDao.getInstance().getLikeMaxList(studydto);
	
	FileDto filedto = new FileDto();
	List<FileDto> fileList = FileDao.getInstance().getLikeMaxList(filedto);
	
	QnADto qnadto =new QnADto();
	List<QnADto> qnaList = QnADao.getInstance().getLikeMaxList(qnadto);
	
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
<title>DreamAdult</title>
<style>

.liked
	{
	  color: #801ee3;
	  opacity: 0.5;
	  margin-bottom: 20px;
	  transform: translate(10px,10px);
	  animation: ani 1s linear infinite;
	}
	
.liked:before
	{
	  content: '';
	  position: absolute;
	}
	
.liked:after
	{
	  content:'';
	  position: absolute;
	  bottom:0;
	}

@keyframes ani{
	  0%{
	    transform: translate(10px,10px) scale(1);
	  }
	  25%{
	    transform: translate(10px,10px) scale(1);
	  }
	  30%{
	    transform: translate(10px,10px) scale(1.4);
	  }
	  50%{
	    transform: translate(10px,10px) scale(1.2);
	  }
	  70%{
	    transform: translate(10px,10px) scale(1.4);
	  }
	  90%{
	    transform: translate(10px,10px) scale(1);
	  }
	  100%{
	    transform: translate(10px,10px) scale(1);
	  }
}

.likeCount{
	color: #801ee3;
}


#sun{
	margin-left: 10px;
	margin-top: 10px;
	transform:translate(-50%, -50%); transition:all .0.2s;
    animation-name:spinCircle;
    animation-duration:.6s;
    animation-iteration-count:infinite;
    animation-timing-function:linear;
}

@keyframes spinCircle {
    from {
        transform:translate(-50%, -50%) rotate(0);
    }
    to {
        transform:translate(-50%, -50%) rotate(180deg);
    }
}


</style>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
</head>
<body>
<jsp:include page="include/navber.jsp"></jsp:include>
<div class="main_page container">
	<h1 class="main_tit">
		오늘의 코린이<br>
		희망차게 하루를 시작해보아요!
		<svg id="sun" xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-brightness-high" viewBox="0 0 16 16">
		  <path d="M8 11a3 3 0 1 1 0-6 3 3 0 0 1 0 6zm0 1a4 4 0 1 0 0-8 4 4 0 0 0 0 8zM8 0a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 0zm0 13a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 13zm8-5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5zM3 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2A.5.5 0 0 1 3 8zm10.657-5.657a.5.5 0 0 1 0 .707l-1.414 1.415a.5.5 0 1 1-.707-.708l1.414-1.414a.5.5 0 0 1 .707 0zm-9.193 9.193a.5.5 0 0 1 0 .707L3.05 13.657a.5.5 0 0 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0zm9.193 2.121a.5.5 0 0 1-.707 0l-1.414-1.414a.5.5 0 0 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .707zM4.464 4.465a.5.5 0 0 1-.707 0L2.343 3.05a.5.5 0 1 1 .707-.707l1.414 1.414a.5.5 0 0 1 0 .708z"/>
		</svg>
	</h1>
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
						<img src="images/00.jpg"/>
						<img src="images/11.jpg"/>
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
							<span class="txt_cate">코드드림</span>
							<svg class="liked" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>&nbsp;&nbsp;&nbsp;&nbsp;<span class="likeCount">x<%=FileLikeDao.getInstance().getCount(fileList.get(0).getNum())%></span>	
						</span>
						<%if(fileList.size()>0) {%>
						<a class="card-main-tit" href="file/private/detail.jsp?num=<%=fileList.get(0).getNum() %>">
							<strong class="tit_card"><%=fileList.get(0).getTitle()%></strong>
						</a>
						<p>
							<span><%=fileList.get(0).getNick()%></span>
							<span><%=fileList.get(0).getGrade()%></span>
							<span><%=fileList.get(0).getRegdate()%></span>
						</p>
						<%} %>
					</span>
					<div class="img-wrap">
						<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/news/79590191017a00001.jpg?type=thumb&opt=C630x472"/>
					</div>
				</li>
				<li class="box box-s">
					<span class="txt_wrap">
						<span class="info_cate">
							<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&opt=C72x72"/>
							<span class="txt_cate">개념쌓기</span>
							<svg class="liked" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>&nbsp;&nbsp;&nbsp;&nbsp;<span class="likeCount">x<%=StudyLikeDao.getInstance().getCount(studyList.get(0).getNum())%></span>
						</span>
						<%if(studyList.size()>0) {%>
						<a class="card-main-tit" href="study/private/detail.jsp?num=<%=studyList.get(0).getNum()%>">
							<strong class="tit_card"><%=studyList.get(0).getTitle()%></strong>
						</a>
						<p>
							<span><%=studyList.get(0).getNick()%></span>
							<span><%=studyList.get(0).getGrade()%></span>
							<span><%=studyList.get(0).getRegdate()%></span>
						</p>
						<%} %>
					</span>
				</li>
				<li class="box box-m">
					<span class="txt_wrap">
						<span class="info_cate">
							<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&opt=C72x72"/>
							<span class="txt_cate">개념쌓기</span>
							<svg class="liked" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>&nbsp;&nbsp;&nbsp;&nbsp;<span class="likeCount">x<%=StudyLikeDao.getInstance().getCount(studyList.get(1).getNum())%></span>
						</span>
						<%if(studyList.size()>1) {%>
						<a class="card-main-tit" href="study/private/detail.jsp?num=<%=studyList.get(1).getNum()%>">
							<strong class="tit_card"><%=studyList.get(1).getTitle()%></strong>
						</a>
						<p>
							<span><%=studyList.get(1).getNick()%></span>
							<span><%=studyList.get(1).getGrade()%></span>
							<span><%=studyList.get(1).getRegdate()%></span>
						</p>
						<%} %>
					</span>
					<div class="img-wrap">
						<img src="https://images.unsplash.com/photo-1621416953228-87ad15716483?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80"/>
					</div>
				</li>
				<li class="box box-m">
					<span class="txt_wrap">
						<span class="info_cate">
							<img src="https://www.kakaocorp.com/page/ico_customer.png"/>
							<span class="txt_cate">묻고답하기</span>
							<svg class="liked" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>&nbsp;&nbsp;&nbsp;&nbsp;<span class="likeCount">x<%=QnALikeDao.getInstance().getCount(qnaList.get(1).getNum())%></span>	
						</span>
						<%if(qnaList.size()>1) {%>
						<a class="card-main-tit" href="qna/private/detail.jsp?num=<%=qnaList.get(1).getNum()%>">
							<strong class="tit_card"><%=qnaList.get(1).getTitle() %></strong>
						</a>
						<p>
							<span><%=qnaList.get(1).getNick() %></span>
							<span><%=qnaList.get(1).getGrade() %></span>
							<span><%=qnaList.get(1).getRegdate() %></span>
						</p>
						<%} %>
					</span>
					<div class="img-wrap">
						<img src="images/cactusLine.png"/>
					</div>
				</li>
				<li class="box box-m">
					<span class="txt_wrap">
						<span class="info_cate">
							<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72"/>
							<span class="txt_cate">코드드림</span>
							<svg class="liked" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>&nbsp;&nbsp;&nbsp;&nbsp;<span class="likeCount">x<%=FileLikeDao.getInstance().getCount(fileList.get(1).getNum())%></span>	
						</span>
						<%if(fileList.size()>1) {%>
						<a class="card-main-tit" href="file/private/detail.jsp?num=<%=fileList.get(1).getNum()%>">
							<strong class="tit_card"><%=fileList.get(1).getTitle()%></strong>
						</a>
						<p>
							<span><%=fileList.get(1).getNick()%></span>
							<span><%=fileList.get(1).getGrade()%></span>
							<span><%=fileList.get(1).getRegdate()%></span>
						</p>
						<%} %>
					</span>
					<div class="img-wrap" style="background:#f77028; height:210px;"></div>
				</li>
				
				<li class="box box-m">
					<span class="txt_wrap">
						<span class="info_cate">
							<img src="https://www.kakaocorp.com/page/ico_customer.png"/>
							<span class="txt_cate">묻고답하기</span>
							<svg class="liked" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>&nbsp;&nbsp;&nbsp;&nbsp;<span class="likeCount">x<%=QnALikeDao.getInstance().getCount(qnaList.get(0).getNum())%></span>	
							<%if(qnaList.size()>0) {%>
							<a class="card-main-tit" href="qna/private/detail.jsp?num=<%=qnaList.get(0).getNum()%>">
								<strong class="tit_card"><%=qnaList.get(0).getTitle() %></strong>
							</a>
							<p>
								<span><%=qnaList.get(0).getNick() %></span>
								<span><%=qnaList.get(0).getGrade() %></span>
								<span><%=qnaList.get(0).getRegdate() %></span>
							</p>
							<%} %>
						</span>
					</span>
					<div class="img-wrap">
						<img src="images/star.png"/>
					</div>
				</li>
				<li class="box box-m">
					<span class="txt_wrap">
						<span class="info_cate">
							<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&opt=C72x72"/>
							<span class="txt_cate">개념쌓기</span>
							<svg class="liked" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>&nbsp;&nbsp;&nbsp;&nbsp;<span class="likeCount">x<%=StudyLikeDao.getInstance().getCount(studyList.get(2).getNum())%></span>
						</span>
						<%if(studyList.size()>2) {%>
						<a class="card-main-tit" href="study/private/detail.jsp?num=<%=studyList.get(2).getNum()%>">
							<strong class="tit_card"><%=studyList.get(2).getTitle()%></strong>
						</a>
						<p>
							<span><%=studyList.get(2).getNick()%></span>
							<span><%=studyList.get(2).getGrade()%></span>
							<span><%=studyList.get(2).getRegdate()%></span>
						</p>
						<%} %>
					</span>
					<div class="img-wrap">
						<img src="https://images.unsplash.com/photo-1540760938999-077b8231d890?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1951&q=80"/>
					</div>
				</li>
				<li class="box box-m">
					<span class="txt_wrap">
						<span class="info_cate">
							<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72"/>
							<span class="txt_cate">코드드림</span>
							<svg class="liked" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>&nbsp;&nbsp;&nbsp;&nbsp;<span class="likeCount">x<%=FileLikeDao.getInstance().getCount(fileList.get(2).getNum())%></span>	
						</span>
						<%if(fileList.size()>2) {%>
						<a class="card-main-tit" href="file/private/detail.jsp?num=<%=fileList.get(2).getNum()%>">
							<strong class="tit_card"><%=fileList.get(2).getTitle()%></strong>
						</a>
						<p>
							<span><%=fileList.get(2).getNick()%></span>
							<span><%=fileList.get(2).getGrade()%></span>
							<span><%=fileList.get(2).getRegdate()%></span>
						</p>
						<%} %>
					</span>
					<div class="img-wrap" style="background:#801ee3; height:210px;"></div>
				</li>
				<li class="box box-s">
					<span class="txt_wrap">
						<span class="info_cate">
							<img src="https://www.kakaocorp.com/page/ico_customer.png" />
							<span class="txt_cate">묻고답하기</span>
							<svg class="liked" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16"><path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/></svg>&nbsp;&nbsp;&nbsp;&nbsp;<span class="likeCount">x<%=QnALikeDao.getInstance().getCount(qnaList.get(2).getNum())%></span>
							<%if(qnaList.size()>2) {%>	
							<a class="card-main-tit" href="qna/private/detail.jsp?num=<%=qnaList.get(2).getNum()%>">
								<strong class="tit_card"><%=qnaList.get(2).getTitle()%></strong>
							</a>
							<p>
								<span><%=qnaList.get(2).getNick() %></span>
								<span><%=qnaList.get(2).getGrade() %></span>
								<span><%=qnaList.get(2).getRegdate() %></span>
							</p>
							<%} %>
						</span>
					</span>
				</li>
			</ul>
		</div>
	</div>
	<div class="wrap-etc row">
		<div class="item_etc col-12 col-xl-6" >
			<div>
				<span class="txt_wrap">
					<h4 class="etc-tit">
						사람과 기술로 일상을 돕는<br>
						코린이 게시판을 볼려면?
					</h4>
					<a id="login_link" class="btn btn-s btn-custom-dark" href="${pageContext.request.contextPath}/users/loginform.jsp">
					로그인 하러가기
					<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-arrow-right-short" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M4 8a.5.5 0 0 1 .5-.5h5.793L8.146 5.354a.5.5 0 1 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L10.293 8.5H4.5A.5.5 0 0 1 4 8z"/>
					</svg>
					</a>
				</span>
			</div>
		</div>
		<div class="item_etc col-12 col-xl-6">
			<div>
				<span class="txt_wrap">
					<h4 class="etc-tit">
						항상 발전하는 코린이와<br>
						함께 하고싶다면?
					</h4>
					<a id="signup_link" class="btn btn-s btn-custom-dark" href="${pageContext.request.contextPath}/users/signup_form.jsp">
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
<jsp:include page="include/footer.jsp"></jsp:include>
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>

<script>
	<%if(isPopup){ %>
		window.open("popup.jsp", "웰컴팝업창", "width=500,height=450,top=100,left=100");
	<%} %>
	<%if(isUpgrade){%>
		window.open("grade_popup.jsp", "등급 업 팝업창", "width=500,height=450,top=100,left=600");
	<%}%>
		
	let id='<%=id%>';
	if(id!='null'){
		document.querySelector("#signup_link").addEventListener("click",function(e){
			Swal.fire({
 				 position: 'top-50 start-50',
 			 	 icon: 'warning',
 				 text: '이미 회원입니다.',
 				 showConfirmButton: false,
 			     timer: 1500
 			})
			e.preventDefault();
		});
		document.querySelector("#login_link").addEventListener("click",function(e){
			Swal.fire({
 				 position: 'top-50 start-50',
 			 	 icon: 'warning',
 				 text: '이미 로그인 했습니다.',
 				 showConfirmButton: false,
 			     timer: 1500
 			})
			e.preventDefault();
		});
	}
</script>
<script src="${pageContext.request.contextPath}/js/grid.js"></script>
</body>
</html>



















