<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" />
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>
	<div class="form-page container">
		<h1 class="main-tit">
		  	<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72"> 
		   	<span>코드공유</span>
	   </h1>
		<form action="<%=request.getContextPath() %>/file/private/upload.jsp" method="post" id="uploadForm" enctype="multipart/form-data">
			<div>
				<label for="category">카테고리</label>
				<select name="category" id="category" class="form-select">
					<option value="whole">선택</option>
					<option value="java">java</option>
					<option value="javascript">javascript</option>
					<option value="jsp">jsp</option>
				</select>
			</div>
			<div class="mt-3">
				<label for="title" class="form-label">제목</label>
				<input type="text" name="title" id="title" class="form-control"/>
			</div>
			<div class="mt-3">
				<label for="fileContent" class="form-label">내용</label>
				<textarea name="fileContent" id="fileContent" class="form-control" cols="30" rows="10"></textarea>
			</div>
			<div class="mt-3">
				<label for="myFile" class="form-label">첨부 파일</label>
				<input type="file" name="myFile" id="myFile" class="form-control"/>
			</div>
			<button type="submit" class="btn btn-m btn-custom-dark">업로드</button>
			<img id="myImage" />
		</form>
	</div>
<script src="<%=request.getContextPath() %>/SmartEditor/js/HuskyEZCreator.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
	var oEditors = [];
	
	nhn.husky.EZCreator.createInIFrame({
	   oAppRef: oEditors,
	   elPlaceHolder: "fileContent",
	   sSkinURI: "${pageContext.request.contextPath}/SmartEditor/SmartEditor2Skin.html",   
	   htParams : {
	      bUseToolbar : true,            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	      bUseVerticalResizer : true,      // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	      bUseModeChanger : true,         // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	      //aAdditionalFontList : aAdditionalFontSet,      // 추가 글꼴 목록
	      fOnBeforeUnload : function(){
	         //alert("완료!");
	      }
	   }, //boolean
	   fOnAppLoad : function(){
	      //예제 코드
	      //oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
	   },
	   fCreator: "createSEditor2"
	});
	
	function pasteHTML() {
	   var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	   oEditors.getById["fileContent"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
	   var sHTML = oEditors.getById["fileContent"].getIR();
	   alert(sHTML);
	}
	   
	
	function setDefaultFont() {
	   var sDefaultFont = '궁서';
	   var nFontSize = 24;
	   oEditors.getById["fileContent"].setDefaultFont(sDefaultFont, nFontSize);
	}
	
	// 폼에 submit 이벤트가 일어났을 때 실행할 함수
	document.querySelector("#uploadForm").addEventListener("submit", function(e){
		oEditors.getById["fileContent"].exec("UPDATE_CONTENTS_FIELD", []); 
		const title=document.querySelector("#title").value;
		const category=document.querySelector("#category").value;
		if(!title && !category){
			Swal.fire({
				 position: 'top-50 start-50',
			 	 icon: 'warning',
				 text: '제목 또는 카테고리를 확인하세요.',
				 showConfirmButton: false,
			     timer: 1500
			})
			e.preventDefault();
		}else if(!category){
			Swal.fire({
				 position: 'top-50 start-50',
			 	 icon: 'warning',
				 text: '카테고리를 선택해 주세요.',
				 showConfirmButton: false,
			     timer: 1500
			})
			e.preventDefault();
		}else if(!title){
			Swal.fire({
				 position: 'top-50 start-50',
			 	 icon: 'warning',
				 text: '제목을 입력해 주세요.',
				 showConfirmButton: false,
			     timer: 1500
			})
			e.preventDefault();
		}
	});	   
</script>
</body>
</html>