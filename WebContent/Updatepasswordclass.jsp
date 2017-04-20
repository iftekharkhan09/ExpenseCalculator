<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.src.controller.Sendmaill" %>
<%@page import="java.sql.PreparedStatement" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String username=session.getAttribute("username").toString();
String password=request.getParameter("password");
Sendmaill mail=new Sendmaill();
boolean success=mail.updatepass(password, username);
if(success)
{
	out.print("Your Password has been successfully updated!!");
}
%>
</body>
</html>