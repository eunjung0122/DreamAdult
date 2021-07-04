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
<title>uploadform.jsp</title>
</head>
<body>
	<div class="container">
		<form action="<%=request.getContextPath() %>/file/private/update.jsp" method="post" id="updateForm" enctype="multipart/form-data">
			<input type="hidden" name="num" value="<%=dto.getNum() %>"/>
			<div>
				<label for="category">카테고리</label>
				<select name="category" id="category">
					<option value="">선택</option>
					<option value="java" <%=dto.getCategory().equals("java") ? "selected" : "" %>>java</option>
					<option value="javascript" <%=dto.getCategory().equals("javascript") ? "selected" : "" %>>javascript</option>
					<option value="jsp" <%=dto.getCategory().equals("jsp") ? "selected" : "" %>>jsp</option>
				</select>
			</div>
			<div>
				<label for="writer">작성자</label>
				<input type="text" name="writer" id="writer" value="<%=dto.getWriter() %>" disabled/>
			</div>
			<div>
				<label for="title">제목</label>
				<input type="text" name="title" id="title" value="<%=dto.getTitle() %>"/>
			</div>
			<div>
				<label for="content">내용</label>
				<textarea name="contnet" id="content" cols="30" rows="10"><%=dto.getContent() %></textarea>
			</div>
			<div>
				<label for="myFile">첨부 파일</label>
				<input type="file" name="myFile" id="myFile"/>
				<p><%=dto.getFileName()%></p>
			</div>
			<button type="submit" >수정 확인</button>
		</form>
	</div>
<script src="<%=request.getContextPath() %>/SmartEditor/js/HuskyEZCreator.js"></script>
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
		// 에디터에 입력한 내용이 textarea 의 value 값이 될 수 있도록 변환한다.
		oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []); 
		// 스마트 에디터 사용하려면  출력한 내용을 등록하기 위해 이 줄은 꼭 필요
		// textarea 이외에 title, category 검증
		const title=document.querySelector("#title").value;
		const category=document.querySelector("#category").value;
		if(!title && !category){
			alert("제목 또는 카테고리를 확인하세요");
			e.preventDefault();
		}else if(!category){
			alert("카테고리를 선택해주세요");
			e.preventDefault();
		}else if(!title){
			alert("제목을 입력해주세요");
			e.preventDefault();
		}
	});	   
</script>
</body>
</html>