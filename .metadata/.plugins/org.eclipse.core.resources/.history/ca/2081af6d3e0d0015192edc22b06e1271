<%@page import="com.src.controller.DBConnector"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Expense</title>
</head>
<body>
	<%
Connection conn=DBConnector.getDBConnection();
String id=request.getParameter("id");
String sql="delete from expense where expense_id=?";
PreparedStatement statement=conn.prepareStatement(sql);
statement.setString(1,id);
int  delq=statement.executeUpdate();
if(delq>0){
	out.print("Deletion has been Successfull!!");
}
	%>
</body>
</html>