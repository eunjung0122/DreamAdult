<%@page import="test.study.dao.StudyDao"%>
<%@page import="test.study.dto.StudyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   int num=Integer.parseInt(request.getParameter("num"));
	StudyDto dto=new StudyDto();
   	dto.setNum(num);
	dto=StudyDao.getInstance().getData(dto);
	String category=dto.getCategory();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/study/private/updateform.jsp</title>
</head>
<body>
<jsp:include page="../../include/navber.jsp"></jsp:include>
<div class="container">
   <h1>글 수정</h1>
   <form action="update.jsp" method="post" id="updateForm">
	   <input type="hidden" name="num" value="<%=num %>" />
	   <div>
	      <label for="writer">작성자</label>
	      <input type="text" id="writer" value="<%=dto.getWriter() %>" disabled/>
	   </div>
	   <div>
	      <label for="nick">닉네임</label>
	      <input type="text" id="nick" value="<%=dto.getNick() %>" disabled/>
	   </div>
	   <div>
	         <label for="title">제목</label>
	         <input type="text" id="title" name="title" value="<%=dto.getTitle()%>"/>
	    </div>
	    <div>
	         <label for="category">말머리</label>
	         <select name="category">
	            <option value="">Please choose an option</option>
	            <option value="java" <%=category.equals("java") ? "selected": "" %> >Java</option>
	            <option value="javascript" <%=category.equals("javascript") ? "selected": "" %>>JavaScript</option>
	            <option value="jsp" <%=category.equals("jsp") ? "selected": "" %>>JSP</option>
	         </select>
	    </div>
	   <div>
	      <label for="content">내용</label>
	      <textarea id="content" name="content"><%=dto.getContent() %></textarea>
	   </div>
	    <button type="submit">수정하기</button>
   </form>
</div>
<!-- SmartEditor 에서 필요한 javascript 로딩  -->
<script src="${pageContext.request.contextPath }/SmartEditor/js/HuskyEZCreator.js"></script>
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
   
   document.querySelector("#updateForm").addEventListener("submit",function(){
	   oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
   });

</script>
</body>
</html>