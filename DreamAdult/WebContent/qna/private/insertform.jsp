<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
<style>
   #content{
      height: 500px;
   }
</style>
<link rel="icon" href="${pageContext.request.contextPath}/images/logo2.png" type="image/x-icon" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" />
</head>
<body>
<jsp:include page="../../include/navber.jsp"><jsp:param value="qna" name="thisPage"/></jsp:include>
<div class="form-page container">
	<nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
  	<ol class="breadcrumb">
	    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}">Home</a></li>
	    <li class="breadcrumb-item active" aria-current="page">QnA</li>
	  </ol>
	</nav>
   <h1 class="main-tit">
  	<img src="https://t1.kakaocdn.net/kakaocorp/kakaocorp/admin/6565671c017800001.png?type=thumb&amp;opt=C72x72"> 
   	<span>큐앤에이</span>
   </h1>
   <form action="insert.jsp" method="post" id="insertForm">
      <div>
         <label for="category">카테고리</label>
         <select name="category" id="category" class="form-select">
            <option value="">선택</option>
            <option value="java">java</option>
            <option value="javascript">javascript</option>
            <option value="jsp">jsp</option>
         </select>
      </div>
      <div class="mt-3">
         <label for="title">제목</label>
         <input type="text" name="title" id="title" class="form-control"/>
      </div>
      <div class="mt-3">
         <label for="content" class="form-label">내용</label>
         <textarea id="content" name="content" class="form-control"></textarea>
      </div>
      <button type="submit" class="btn btn-m btn-custom-dark">저장</button>
   </form>
</div>
<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
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
   
   //폼에 submit 이벤트가 일어났을 때 실행할 함수 등록
   document.querySelector("#insertForm").addEventListener("submit", function(e){
          //에디터에 입력한 내용이 textarea 의 value 값이 될 수 있도록 변환한다.
          oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
          //textarea 이외에 입력한 내용을 여기서 검증하고
          const title=document.querySelector("#title").value;
          const category=document.querySelector("#category").value;
          //만일 폼 제출을 막고 싶으면
          //e.preventDefault();
          //을 수행하게 해서 폼 제출을 막아준다.
          if(title=="" && category==""){
        	  	e.preventDefault();
	  			Swal.fire({
	  				 position: 'top-50 start-50',
	  			 	 icon: 'warning',
	  				 text: '제목 또는 카테고리를 확인하세요.',
	  				 showConfirmButton: false,
	  			     timer: 1500
	  			})
	  		}else if(category==""){
	  			e.preventDefault();
	  			Swal.fire({
	  				 position: 'top-50 start-50',
	  			 	 icon: 'warning',
	  				 text: '카테고리를 선택해 주세요.',
	  				 showConfirmButton: false,
	  			     timer: 1500
	  			})	
	  		}else if(title==""){
	  			e.preventDefault();
	  			Swal.fire({
	  				 position: 'top-50 start-50',
	  			 	 icon: 'warning',
	  				 text: '제목을 입력해 주세요.',
	  				 showConfirmButton: false,
	  			     timer: 1500
	  			})
	  		}
         });
</script>
</body>
</html>