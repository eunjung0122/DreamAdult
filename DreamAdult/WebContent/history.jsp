<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<link rel="stylesheet" href="historystyle.css" />
<style>
.contain_align{
	width:364px;
	margin:auto;
	
	/*border:1px solid red;*/
}

.page_tit{
	margin:80px 0;
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
	color:#000000;
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
	margin-bottom:16px;
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
.list_history>div>div{
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
.team_img{
		height:95px;
		background-image: url("images/KakaoTalk_20210713_164611260_01.png");
  		background-size: cover;
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
	.section-history>h2{
		margin-bottom:20px;
	}
	
	.thumb_img{
		width:192px;
	}
	.team_img{
		height:144px;
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
	.team_img{
		height:162px;
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

.last_list{
	margin-bottom:100px;
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
		margin-top:50px;
	}
	.section-history>h2{
		font-size:30px;
		margin-bottom:26px;
	}
	.thumb_img{
		width:240px;
	}
	.team_img{
		height:180px;
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
<jsp:include page="include/navber.jsp"><jsp:param value="history" name="thisPage"/></jsp:include>
<div class="contain_align">
	<h1 class="page_tit">
	    <span class="tit_header">
	    	<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6562b710017800001.png?type=thumb&opt=C72x72" alt="">
	    	<span>???????????????</span>
	    </span>
	    <span class="txt_tit">
	        ??? ?????? ????????? ????????? Dream Adult
	    </span>
	</h1>
	<section class="section-history">
		<h2>????????? ????????????</h2>
		<ul>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<div>
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/21b3cbd9017900001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021??? 6??? 18???</span>
							<strong class="tit_item">?????? ?????? , ???????????? ????????? ???</strong>
							<span class="tag_item">
								<span class="txt_tag">#?????????</span>
								<span class="txt_tag">#???????????????</span>
								<span class="txt_tag">#3???????????????</span>
							</span>
						</div>
					</div>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<div>
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/21c43c50017900001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021??? 6??? 30???</span>
							<strong class="tit_item">PROJECT, DREAM ADULT ??????</strong>
							<span class="tag_item">
								<span class="txt_tag">#Amazing!</span>
								<span class="txt_tag">#?????????????</span>
								<span class="txt_tag">#??????????????????</span>
							</span>
						</div>
					</div>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<div>
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/638e6e54017800001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021??? 7??? 1???</span>
							<strong class="tit_item">Chapter 1, PROJECT ??????</strong>
							<span class="tag_item">
								<span class="txt_tag">#?????????????????????</span>
								<span class="txt_tag">#??????????????????????????</span>
								<span class="txt_tag">#????????????????</span>
							</span>
						</div>
					</div>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<div>
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/21d2825e017900001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021??? 7??? 5???</span>
							<strong class="tit_item">Chapter 2, ???????????? ?????? ?????? ??????</strong>
							<span class="tag_item">
								<span class="txt_tag">#Unbelievable!</span>
								<span class="txt_tag">#?????????3???</span>
								<span class="txt_tag">#?????????</span>
							</span>
						</div>
					</div>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<div>
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/41f0c3c0017a00001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021??? 7??? 8???</span>
							<strong class="tit_item">Chapter 3, ????????? & ????????? ?????? ??????</strong>
							<span class="tag_item">
								<span class="txt_tag">#????????????</span>
								<span class="txt_tag">#??????????????????</span>
								<span class="txt_tag">#??????</span>
							</span>
						</div>
					</div>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<div>
						<div class="wrap_thumb">
							<div class="team_img thumb_img"></div>
						</div>
						<div class="wrap_cont">
							<span class="txt_date">2021??? 7??? 9???</span>
							<strong class="tit_item">??????! ???????????? ????????? ????????????</strong>
							<span class="tag_item">
								<span class="txt_tag">#???????????????????????????</span>
								<span class="txt_tag">#??????????????????</span>
								<span class="txt_tag">#???????????????</span> 
								<span class="txt_tag">#??????????????????</span>
							</span>
						</div>
					</div>
				</div>
			</li>
			<li class="list_history">
				<span class="list_circle"></span>
				<div class="list_line">
					<div>
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/history/21e919a9017900001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021??? 7??? 14???</span>
							<strong class="tit_item">Chapter 4, ?????? ????????? ??? ?????? & ????????? ??????</strong>
							<span class="tag_item">
								<span class="txt_tag">#???????????????????????????????</span>
								<span class="txt_tag">#??????????????????</span>
								<span class="txt_tag">#???????????????</span>
							</span>
						</div>
					</div>
				</div>
			</li>
			<li class="list_history last_list">
				<span class="list_circle"></span>
				<div>
					<div>
						<span class="wrap_thumb">
							<img class="thumb_img" src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6392eed2017800001.png?type=thumb&opt=C480x360" alt="" />
						</span>
						<div class="wrap_cont">
							<span class="txt_date">2021??? 7??? 16???</span>
							<strong class="tit_item">DERAM ADULT, ????????? ?????? ?????????</strong>
							<span class="tag_item">
								<span class="txt_tag">#???????????????</span>
								<span class="txt_tag">#???????????????</span>
								<span class="txt_tag">#???????????????</span>
							</span>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</section>
</div>
</body>
</html>