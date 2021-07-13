<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	//파일을 업로드할 절대 경로를 메소드를 통해서 얻어오기
	String path=request.getServletContext().getRealPath("/upload");
	//경로 확인!   
	System.out.println(path);
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
		
	// 전송된 문자열과 파일의 정보는 mr 객체의 메소드를 통해서 얻어낼수 있음
	String writer = (String)session.getAttribute("id");
	String category=mr.getParameter("category");
	String title=mr.getParameter("title");
	String content=mr.getParameter("fileContent");
	String orgFileName=mr.getOriginalFileName("myFile");  
	
	
	FileDto dto = new FileDto();
	dto.setWriter(writer);
	dto.setCategory(category);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setOrgFileName(orgFileName);
	if(orgFileName!=null){
		File myFile=mr.getFile("myFile");
		long fileSize=myFile.length();
		String saveFileName=mr.getFilesystemName("myFile");
		dto.setSaveFileName(saveFileName);
		dto.setFileSize(fileSize);
	}
	
	boolean isSuccess = FileDao.getInstance().insert(dto);
		
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
</head>
<body>
	<%if(isSuccess){ %>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script>
   	Swal.fire({
		 position: 'top-50 start-50',
		 icon: 'success',
		 text: '정상적으로 업로드 되었습니다.',
		 showConfirmButton: false,
		 timer: 1500
	}).then(function(){
		location.href="${pageContext.request.contextPath}/file/list.jsp";
	});    
   </script>
	   <%}else{ %>
	   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	   <script>
		 Swal.fire({
			 position: 'top-50 start-50',
		 	 icon: 'error',
			 text: '파일이 정상적으로 업로드 되지 않았습니다.',
			 showConfirmButton: false,
		     timer: 1500
		}).then(function(){
				location.href="${pageContext.request.contextPath}/file/private/uploadform.jsp";
		});	
	   </script>
	   <%} %>
</body>
</html>