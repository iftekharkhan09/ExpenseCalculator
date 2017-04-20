<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.Connection"%>
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
Connection conn=DBConnector.getDBConnection();
String id=request.getParameter("id");
String update_transaction="update transaction set is_paid='Y' where transaction_id=?";
PreparedStatement trans_statement=conn.prepareStatement(update_transaction);
trans_statement.setString(1, id);
int update=trans_statement.executeUpdate();
if(update >0)
{
%>
<%} %>
</body>
</html>