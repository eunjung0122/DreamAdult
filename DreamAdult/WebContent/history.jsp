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
.txt-tit{
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
	padding-bottom:48px;
	border-left:1px solid #eeeeee;
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
	    <span class="txt-tit">
	        더 나은 세상을 만드는 Dream Adult
	    </span>
	</h1>
	<section class="section-history">
		<h2>연도별 히스토리</h2>
		<ul>
			<li class="list_history">
				<span class="list_circle"></span>
				<div>
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/21c43c50017900001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2020년 11월</span>
							<strong class="tit_item">카카오 캐릭터 IP에 관한 조금 자세한 이야기들</strong>
							<span class="tag_item">
								<span class="txt_tag">#카카오프렌즈</span>
								<span class="txt_tag">#춘식이</span>
								<span class="txt_tag">#니니즈</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div>
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/21e919a9017900001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2020년 11월</span>
							<strong class="tit_item">카카오 캐릭터 IP에 관한 조금 자세한 이야기들</strong>
							<span class="tag_item">
								<span class="txt_tag">#카카오프렌즈</span>
								<span class="txt_tag">#춘식이</span>
								<span class="txt_tag">#니니즈</span>
							</span>
						</div>
					</a>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div>
					<a href="">
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2020년 11월</span>
							<strong class="tit_item">카카오 캐릭터 IP에 관한 조금 자세한 이야기들</strong>
							<span class="tag_item">
								<span class="txt_tag">#카카오프렌즈</span>
								<span class="txt_tag">#춘식이</span>
								<span class="txt_tag">#니니즈</span>
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