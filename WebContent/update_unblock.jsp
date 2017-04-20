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
<body>
<% String id=request.getParameter("id");
Connection conn=DBConnector.getDBConnection();
String sql="update staff set blocked='Y' where staff_id=?";
PreparedStatement statement=conn.prepareStatement(sql);
statement.setString(1,id);
int updatee=statement.executeUpdate();
response.sendRedirect("admin_page.jsp");
%>
</body>
</html>