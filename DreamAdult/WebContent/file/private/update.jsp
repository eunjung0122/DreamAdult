<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//파일을 업로드할 절대 경로를 메소드를 통해서 얻어오기
	String path=request.getServletContext().getRealPath("/upload");
	//만일 폴더가 만들어져 있지 않다면 폴더를 만든다.
	File file=new File(path);
	if(!file.exists()){
		file.mkdir();
	}
	
	// cos.jar 에서 제공해주는 MultiPartRequest 객체 생성하기
	MultipartRequest mr=new MultipartRequest(request,
		path,  
	    1024*1024*100, //최대 업로드 사이즈 제한
	    "utf-8", //한글 파일명 깨지지 않도록 인코딩 설정 
	    new DefaultFileRenamePolicy()); //동일한 파일명이 있으면 자동으로 파일명 바꿔서 저장하도록
	
	int num=Integer.parseInt(mr.getParameter("num"));
	String category=mr.getParameter("category");
	String title=mr.getParameter("title");
	String content=mr.getParameter("content"); 
	String existFile=mr.getParameter("myFile2"); //기존 첨부 파일
	long existSize= Long.parseLong(mr.getParameter("myFileSize"));
	
	FileDto dto = new FileDto();
	dto.setCategory(category);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setNum(num);
	
	File myFile=mr.getFile("myFile");
	String orgFileName = mr.getOriginalFileName("myFile");
	String saveFileName = mr.getFilesystemName("myFile");
	
	if(orgFileName == null){
		dto.setOrgFileName(existFile);
		dto.setSaveFileName(existFile);
		dto.setFileSize(existSize);
		
	}else{
		dto.setOrgFileName(orgFileName);
		dto.setSaveFileName(saveFileName);
		long fileSize=myFile.length();
		dto.setFileSize(fileSize);
	}
	
	
	
	
	boolean isSuccess = FileDao.getInstance().update(dto);
	 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
</head>
<body>
	<%if(isSuccess){ %>
      <script>
         alert("글이 수정 되었습니다");
         location.href="<%=request.getContextPath() %>/file/list.jsp";
      </script>
   <%}else{ %>
      <h1>알림</h1>
      <p>
	   글 수정 실패!
         <a href="<%=request.getContextPath() %>/file/private/updateform.jsp?num=<%=dto.getNum()%>">다시 시도</a>
      </p>
   <%} %>
</body>
</html>