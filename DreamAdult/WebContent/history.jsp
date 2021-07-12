<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<jsp:include page="include/resource.jsp"></jsp:include>
<style>
.txt-tit{
    display:block;
}


.list_history>a{
	/*display:block;*/
	border:1px solid red;
}
.list_history>a>div{
	/*display:block;*/
	display:flex;
	border:1px solid blue;
}
.wrap_thumb{
	display:inline-block;
	border:1px solid green;
}
.thumb_img{
	border-radius:6%;
}
.wrap_cont{
	display:inline;
	border:1px solid gray;
}
.wrap_cont span, .wrap_cont strong{
	display:inline;
	border:1px solid gold;
}

.list_history::after{
	content:"●";
}
</style>
</head>
<body>
<jsp:include page="include/navber.jsp"></jsp:include>
<div class="container">
	<h1>
	    <em>
	        <img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6562b710017800001.png?type=thumb&opt=C72x72" alt="">
	               히스토리
	    </em>
	    <span class="txt-tit">
	        더 나은 세상을 만드는 Dream Adult
	    </span>
	</h1>
	<section>
		<h2>연도별 히스토리</h2>
		<ul>
			<li class="list_history">
				<a href="">
					<div>
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
					</div>
				</a>
			</li>
		</ul>
	</section>
</div>

</body>
</html>