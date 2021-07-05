<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String isPopup=request.getParameter("isPopup");

	if(isPopup !=null){
		Cookie cook=new Cookie("isPopup", isPopup);
		cook.setMaxAge(60);
		response.addCookie(cook);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nopopup.jsp</title>
</head>
<body>
	nopopup.jsp 페이지
	<script>
		self.close();
	</script>
</body>
</html>