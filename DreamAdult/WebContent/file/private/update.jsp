<%@page import="test.file.dao.FileDao"%>
<%@page import="test.file.dto.FileDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//한글 깨지지 않도록
	request.setCharacterEncoding("utf-8");
	
	//파일을 업로드할 절대 경로를 메소드를 통해서 얻어오기 (WebContent 하위의 upload 폴더)
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
	    /*
			생성 처리가 끝나는 순간 업로드 처리는 끝난것임.
			MultipartRequest 객체가 성공적으로 생성되면 파일 업로드가 성공된 것
		*/
	
	// 전송된 문자열과 파일의 정보는 mr 객체의 메소드를 통해서 얻어낼수 있음, 파일 업로드 전송 방식은 request 사용불가 
	int num=Integer.parseInt(mr.getParameter("num"));
	String category=mr.getParameter("category");
	String title=mr.getParameter("title");
	String content=mr.getParameter("content");
	// <input type="file" name="myFile" /> 을 통해서 업로드된 파일을 access 할수 있는 File 객체
	//File myFile=mr.getFile("myFile"); // access 할수 있는 File 객체가 있어야지 크기를 알아낼 수 있음.
	//파일의 크기 (byte)
	//long fileSize=myFile.length(); // 파일을 얻어오기 위해 파일 크기를 알아냄. 
	//원본 파일명 
	//String orgFileName=mr.getOriginalFileName("myFile");
	/*
		파일 시스템에 저장된 파일명
	    - upload 폴더안에 동일한 이름의 파일이 없으면 원본 파일명과 동일하게 저장된다.
	    - upload 폴더안에 동일한 이름의 파일이 있으면 파일명 뒤에 1, 2, 3 ... 숫자를 자동으로 부여해서 저장한다.
	    ex)  image.jpg  image1.jpg  image2.jpg ...
	*/
	String saveFileName=mr.getFilesystemName("myFile"); 
	// 'myFile' 은 name value 의 이름과 같아야함.    
	// 파일 다운로드를 위해선 파일 크기, 원래 이름, 저장된 이름의 정보가 있어야함.
	   
	FileDto dto = new FileDto();
	dto.setCategory(category);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setFileName(saveFileName);
	dto.setNum(num);
	
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