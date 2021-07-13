<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
.contain_align{
	width:364px;
	margin:auto;
	
	/*border:1px solid red;*/
}

.page_tit{
	padding-top:48px;
}
.tit_header{
	display:flex;
	align-items:center;
	font-style:normal;
	font-size:32px;
	font-weight:700;
}
.tit_header>img{
	width:40px;
	height:40px;
	/*display:inline-block;*/
}
.tit_header>span{
	padding-top:4px;
	padding-left:10px;
}
.txt_tit{
    display:block;
    
    font-size:22px;
    font-weight:500;
    /*color:#666666;*/
    padding-top:4px;
}

.section-history{
	margin-top:24px;
}
.section-history>h2{
	font-size:26px;
	font-weight:600;
	color:#000000;
}
.section-history>ul{
	/*display:block;*/
	list-style:none;
	padding-left:0;
}

.list_history{
	position:relative;	
	/*display:block;*/
}
.list_history>div{
	/*display:block;*/
	margin-left:3px;
	padding-left:20px;
}
.list_line{
	border-left:1px solid #eeeeee;
	padding-bottom:48px;
}
.list_history>div>a{
	/*display:block;*/
	display:flex;
}
.wrap_thumb{
	display:inline-block;
}
.thumb_img{
	border-radius:6%;
	
	width:126px;
}
.wrap_cont{
	width:100%;
	
	margin-left:30px;
}
.txt_date, .tit_item, .tag_item{
	display:block;
	/*border:1px solid gold;*/
}

.txt_date{
	font-size:12px;
	color:#333333;
}
.tit_item{
	max-height: 46px;
	font-size:15px;
	color:#000000;
	line-height: 23px;
	margin-top:4px;
}
.tag_item{
	font-size:11px;
	color:#888888;
	margin-top:12px;
}
.txt-tag{
	padding-right:3px;
}

.list_circle{
	width:7px;
	height:7px;
	background-color:#000000;
	border-radius:4px;
	position:absolute;
}

@media (min-width: 768px) {
	.contain_align{
		width:630px;
	}
	
	.txt_tit{
		padding-top:8px;
	}
	
	.section-history{
		margin-top:34px;
	}
	
	.thumb_img{
		width:192px;
	}
	
	.list_circle{
		width:10px;
		height:10px;
		border-radius:5px;
	}
	.list_history>div{
		/*display:block;*/
		margin-left:4px;
		padding-left:48px;
	}
	.list_line{
		border-left:2px solid #eeeeee;
		padding-bottom:60px;
	}
	.wrap_cont{
		margin-left:48px;
	}
	.txt_date{
		font-size:16px;
	}
	.tit_item{
		max-height: 65px;
		font-size:24px;
		line-height: 32px;
		margin-top:12px;
	}
	.tag_item{
		font-size:13px;
		margin-top:20px;
	}
}

@media (min-width: 992px) {
	.contain_align{
		width:952px;
	}
	
	.tit_header{
		font-size:36px;
	}
	.tit_header>img{
		width:44px;
		height:44px;
	}
	.tit_header>span{
		padding-left:12px;
	}
	
	.txt_tit{
		padding-top:10px;
		font-size:26px;
	}
	
	.section-history{
		margin-top:38px;
	}
	.thumb_img{
		width:216px;
	}
	
	.txt_date{
		font-size:18px;
	}
	.tit_item{
		max-height: 80px;
		font-size:30px;
		line-height: 40px;
	}
	.tag_item{
		font-size:16px;
		margin-top:24px;
	}
}


@media (min-width: 1400px) {
	.contain_align{
		width:1296px;
	}
	
	.tit_header{
		font-size:46px;
	}
	.tit_header>img{
		width:54px;
		height:54px;
	}
	.tit_header>span{
		padding-left:14px;
	}
	.txt_tit{
		padding-top:14px;
		font-size:34px;
	}
	
	.section-history{
		margin-top:40px;
	}
	.section-history>h2{
		font-size:30px;
	}
	.thumb_img{
		width:240px;
	}
	.list_circle{
		width:12px;
		height:12px;
		border-radius:6px;
	}
	.list_history>div{
		margin-left:5px;
		padding-left:62px;
	}
	.list_line{
		border-left:3px solid #eeeeee;
		padding-bottom:72px;
	}
	
	.txt_date{
		font-size:22px;
	}
	.tit_item{
		max-height: 80px;
		font-size:36px;
		line-height: 40px;
	}
	.tag_item{
		font-size:20px;
	}
}
</style>
</head>
<body>
<jsp:include page="include/navber.jsp"></jsp:include>
<div class="contain_align">
	<h1 class="page_tit">
	    <span class="tit_header">
	    	<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6562b710017800001.png?type=thumb&opt=C72x72" alt="">
	    	<span>히스토리</span>
	    </span>
	    <span class="txt_tit">
	        더 나은 세상을 만드는 Dream Adult
	    </span>
	</h1>
	<section class="section-history">
		<h2>연도별 히스토리</h2>
		<ul>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/21c43c50017900001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021년 6월 18일</span>
							<strong class="tit_item">두근 두근 , 그녀들의 첫만남 ♥</strong>
							<span class="tag_item">
								<span class="txt_tag">#팀결성</span>
								<span class="txt_tag">#비대면투표</span>
								<span class="txt_tag">#3조가짱이지</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/21e919a9017900001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021년 6월 30일</span>
							<strong class="tit_item">PROJECT, DREAM ADULT 탄생</strong>
							<span class="tag_item">
								<span class="txt_tag">#Amazing!</span>
								<span class="txt_tag">#아니벌써?</span>
								<span class="txt_tag">#순로로운출발</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021년 7월 1일</span>
							<strong class="tit_item">Chapter 1, PROJECT 회의</strong>
							<span>-사이트의 전체적인 구조 및 기능들에 대한 구성 계획</span>
							<span class="tag_item">
								<span class="txt_tag">#뼛속까지개발자</span>
								<span class="txt_tag">#아니?처음본거맞아?</span>
								<span class="txt_tag">#분위기무엇?</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021년 7월 5일</span>
							<strong class="tit_item">Chapter 2, 사이트의 기본 뼈대 구축</strong>
							<span>-회원관리를 위한 기능들(회원가입, 로그인, 로그아웃, servlet 등), 기본틀이되는 게시판 기능(글 추가, 수정, 삭제, 리스트, 디테일 등), 댓글 기능 구현</span>
							<span class="tag_item">
								<span class="txt_tag">#Unbelievable!</span>
								<span class="txt_tag">#열정의3조</span>
								<span class="txt_tag">#빨간색</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021년 7월 8일</span>
							<strong class="tit_item">Chapter 3, 좋아요 & 북마크 기능 구현</strong>
							<sapan>
								좋아요&북마크 기능, index 페이지에 좋아요 많은 순으로 나열되는 리스트 기능, 회원들을 위한 글모아보기 기능 등의 
								추가적인 기능들 구현
							</sapan>
							<span class="tag_item">
								<span class="txt_tag">#해내다니</span>
								<span class="txt_tag">#우리도몰랐다</span>
								<span class="txt_tag">#뿌듯</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021년 7월 9일</span>
							<strong class="tit_item">찰칵! 그녀들의 소소한 단합대회</strong>
							<span class="tag_item">
								<span class="txt_tag">#이상한사람아니예요</span>
								<span class="txt_tag">#잊지못할추억</span>
								<span class="txt_tag">#정호쌤짱짱</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021년 7월 14일</span>
							<strong class="tit_item">Chapter 4, 기능 테스트 및 수정 & 디자인 구현</strong>
							<span>전체적인 디자인</span>
							<span class="tag_item">
								<span class="txt_tag">#해내다니</span>
								<span class="txt_tag">#우리도몰랐다</span>
								<span class="txt_tag">#뿌듯</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021년 7월 16일</span>
							<strong class="tit_item">DERAM ADULT, 세계에 발을 내딛다</strong>
							<span class="tag_item">
								<span class="txt_tag">#접속량폭팔</span>
								<span class="txt_tag">#사이트다운</span>
								<span class="txt_tag">#광고받아요</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<!--  <span class="txt_date">2020년 11월</span>-->
							<strong class="tit_item">프로젝트를 마치며...</strong>
							<span class="tag_item">
								<span class="txt_tag">#프로젝트 시작전엔</span>
								<span class="txt_tag">#지금까지 배운걸로</span>
								<span class="txt_tag">#무언가를 만들수 있긴 할까 의심이 들었었는데</span>
								<span class="txt_tag">#막상시작하고보니</span>
								<span class="txt_tag">#지금까지 배운범주로</span>
								<span class="txt_tag">#왠만한것이 모두 구현 가능했다</span>
								<span class="txt_tag">#DreamAult를제작하면서</span>
								<span class="txt_tag">#배웠던것들이 진짜 내것이 되는것같은느낌에</span>
								<span class="txt_tag">#이번 세미프로젝트 우리에게 큰의미가 있었다</span>
								<!--  
								<span class="txt_tag">#시작하기전에</span>
								<span class="txt_tag">#배운게많다라는</span>
								<span class="txt_tag">#생각을못해서</span>
								<span class="txt_tag">#버벅거리기만하는거아닌가</span>
								<span class="txt_tag">#뭐가될까생각했었는데</span>
								<span class="txt_tag">#새로운기능을만들때</span>
								<span class="txt_tag">#지금까지로배운것으로</span>
								<span class="txt_tag">#구현이가능했던부분이신기하였다</span>
								<span class="txt_tag">#프로젝트라는게</span>
								<span class="txt_tag">#큰의미가있지않았나</span>
								-->
								<!--  
								<span class="txt_tag">#끝나도</span>
								<span class="txt_tag">#끝이아니다</span>
								<span class="txt_tag">#우린계속달린다</span>
								<span class="txt_tag">#선생님</span>
								<span class="txt_tag">#3조이대로</span>
								<span class="txt_tag">#행복하게해주세요</span>
								<span class="txt_tag">#우리함께forever</span>
								<span class="txt_tag">#다른조도</span>
								<span class="txt_tag">#화이팅</span>
								<span class="txt_tag">#멋있다!이쁘다!</span>-->
							</span>
						</div>
					</a>
				</div>
			</li>
			
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2027년 7월 16일</span>
							<strong class="tit_item">DERAM ADULT, 세계에 발을 내딛다</strong>
							<span class="tag_item">
								<span class="txt_tag">#접속량폭팔</span>
								<span class="txt_tag">#사이트다운</span>
								<span class="txt_tag">#광고받아요</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2027년 7월 16일</span>
							<strong class="tit_item">DERAM ADULT, 세계에 발을 내딛다</strong>
							<span class="tag_item">
								<span class="txt_tag">#접속량폭팔</span>
								<span class="txt_tag">#사이트다운</span>
								<span class="txt_tag">#광고받아요</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2027년 7월 16일</span>
							<strong class="tit_item">DERAM ADULT, 세계에 발을 내딛다</strong>
							<span class="tag_item">
								<span class="txt_tag">#접속량폭팔</span>
								<span class="txt_tag">#사이트다운</span>
								<span class="txt_tag">#광고받아요</span>
							</span>
						</div>
					</a>
				</div>
			</li>
		</ul>
	</section>
</div>

</body>
</html>