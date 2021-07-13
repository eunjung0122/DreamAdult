<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String isPopup=request.getParameter("isPopup");

	if(isPopup !=null){
		Cookie cook=new Cookie("isPopup", isPopup);
		cook.setMaxAge(60*60*24);
		response.addCookie(cook);
	}
	
	String gradePopup=request.getParameter("gradePopup");
	if(gradePopup !=null){
		Cookie cook=new Cookie("gradePopup", gradePopup);
		cook.setMaxAge(60*60*24*365);
		response.addCookie(cook);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Adult</title>
</head>
<body>
	nopopup.jsp 페이지
	<script>
		self.close();
	</script>
</body>
</html>