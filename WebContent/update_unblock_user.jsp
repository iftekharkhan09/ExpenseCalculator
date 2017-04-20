<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<body>
	<% String id=request.getParameter("id");
Connection conn=DBConnector.getDBConnection();
String sql="update user set is_active='N' where user_id=?";
PreparedStatement statement=conn.prepareStatement(sql);
statement.setString(1,id);
int updatee=statement.executeUpdate();
String set_leaving_date="update user set leaving_date=NOW() where user_id=?"; 
PreparedStatement statement1=conn.prepareStatement(set_leaving_date);
statement1.setString(1,id);
int leaving_date_update=statement1.executeUpdate();
response.sendRedirect("admin_page.jsp");
%>
</body>
</html>