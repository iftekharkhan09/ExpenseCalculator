<%@page import="com.src.Model.Staff"%>
<%@page import="com.src.controller.UserLogin"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<%@page import="java.sql.*"%>
<%@page import="com.src.controller.*"%>
<body>
	<jsp:useBean id="staff" class="com.src.Model.Staff" />
	<jsp:setProperty property="*" name="staff" />
	<%
		UserLogin login = new UserLogin();
		if (login.is_admin(staff)) {
			session.setAttribute("admin", staff);
		} 
		login.setStaff(staff);
		
		if (login.validate(staff)) {
			session.setAttribute("username", staff.getUsername());
	%>
	<jsp:include page="Home.jsp"></jsp:include>
	<%
		} else {
	%>
	<jsp:include page="loginfailure.jsp"></jsp:include>
	<%
		}
	%>
</body>
</html>