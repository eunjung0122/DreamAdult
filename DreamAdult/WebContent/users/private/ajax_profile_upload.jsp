<%@page import="test.users.dao.UsersDao"%>
<%@page import="test.users.dto.UsersDto"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
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
	MultipartRequest mr=new MultipartRequest(request, //HttpServletRequest
			path, //파일을 저장할 경로 
			1024*1024*10, //최대 업로드 사이즈 제한
			"utf-8", //한글 파일명 깨지지 않도록 인코딩 설정 
			new DefaultFileRenamePolicy()); //동일한 파일명이 있으면 자동으로 파일명 바꿔서 저장하도록
			
	//MultipartRequest 객체가 성공적으로 생성되면 파일 업로드가 성공된 것이다.
	//전송된 문자열과 파일의 정보는 mr 객체의 메소드를 통해서 얻어낼수 있다. 
	
	//파일 시스템(WebContent/upload 폴더)에 저장된 파일명
	String saveFileName=mr.getFilesystemName("image");
		  
	// session 영역에 있는 아이디 읽어오기
	String id=(String)session.getAttribute("id");
	// DB 에 저장할 이미지 경로 구성하기
	String imagePath="/upload/"+saveFileName;
	//이미지 경로를 JSON 으로 응답하기 
%>    
{"imagePath":"<%=imagePath %>"}











