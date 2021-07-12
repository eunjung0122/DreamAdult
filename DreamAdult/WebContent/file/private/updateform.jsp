<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="test.file.dao.FileDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int num=Integer.parseInt(request.getParameter("num"));
	FileDto dto=FileDao.getInstance().getData(num);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" />
</head>
<body>
<jsp:include page="../../include/navber.jsp"><jsp:param value="file" name="thisPage"/></jsp:include>
	<div class="form-page container">
		<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
		  <ol class="breadcrumb">
		    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
		    <li class="breadcrumb-item active" aria-current="page">File</li>
		  </ol>
		</nav>
		<h1 class="main-tit">
		  	<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6564a0f6017800001.png?type=thumb&opt=C72x72"> 
		   	<span>코드공유</span>
	   </h1>
		<form action="<%=request.getContextPath() %>/file/private/update.jsp" method="post" id="updateForm" enctype="multipart/form-data">
			<input type="hidden" name="num" value="<%=dto.getNum() %>"/>
			<div>
				<label for="category">카테고리</label>
				<select name="category" id="category" class="form-select">
					<option value="whole">선택</option>
					<option value="java" <%=dto.getCategory().equals("java") ? "selected" : "" %>>java</option>
					<option value="javascript" <%=dto.getCategory().equals("javascript") ? "selected" : "" %>>javascript</option>
					<option value="jsp" <%=dto.getCategory().equals("jsp") ? "selected" : "" %>>jsp</option>
				</select>
			</div>
			<div class="mt-3"> 
				<label for="writer" class="form-label">작성자</label>
				<input type="text" name="writer" id="writer"  class="form-control" value="<%=dto.getWriter() %>" disabled/>
			</div>
			<div class="mt-3"> 
				<label for="title" class="form-label">제목</label>
				<input type="text" name="title" id="title"  class="form-control" value="<%=dto.getTitle() %>" />
			</div>
			<div class="mt-3"> 
				<label for="content" class="form-label">내용</label>
				<textarea name="contnet" id="content" cols="30" rows="10" class="form-control">
				<%if(dto.getContent()!=null) {
					dto.getContent();
				} %>
				</textarea>
			</div>
			<div class="mt-3"> 
				<label for="myFile" class="form-label">첨부 파일</label>
				<input type="hidden" name="myFile2" id="myFile2" value="<%=dto.getOrgFileName()%>" />
				<input type="hidden" name="myFileSize" id="myFileSize" value="<%=dto.getFileSize()%>" />
				<input type="file" name="myFile" id="myFile" class="form-control"/>
				<p><%=dto.getOrgFileName()%></p>
			</div>
			<button type="submit" class="btn btn-s btn-custom-dark">수정 확인</button>
		</form>
	</div>
<script src="<%=request.getContextPath()%>/SmartEditor/js/HuskyEZCreator.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script>
	var oEditors = [];
	
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	
	nhn.husky.EZCreator.createInIFrame({
	   oAppRef: oEditors,
	   elPlaceHolder: "content",
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
	   oEditors.getById["content"].exec("PASTE_HTML", [sHTML]);
	}
	
	function showHTML() {
	   var sHTML = oEditors.getById["content"].getIR();
	   alert(sHTML);
	}
	   
	function setDefaultFont() {
	   var sDefaultFont = '궁서';
	   var nFontSize = 24;
	   oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
	}
	
	// 폼에 submit 이벤트가 일어났을 때 실행할 함수 등록
	document.querySelector("#updateForm").addEventListener("submit", function(e){
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); 
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