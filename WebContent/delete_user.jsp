<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@page import="java.sql.*" %>
<%@page import="com.src.controller.*" %>
<%
String id=request.getParameter("id");
Connection conn=DBConnector.getDBConnection();
String sql="delete from user where user_id=?";
PreparedStatement statement=conn.prepareStatement(sql);
statement.setString(1,id);
int  delq=statement.executeUpdate();
response.sendRedirect("admin_page.jsp");
%>
</body>
</html>