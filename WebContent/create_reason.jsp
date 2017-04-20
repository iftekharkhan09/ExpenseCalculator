<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.*" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<jsp:useBean id="reason" class="com.src.Model.Reason"></jsp:useBean>
<jsp:setProperty property="*" name="reason"/>
<body>
<%
Connection conn=DBConnector.getDBConnection();
String desc=reason.getReason_description();
String sql="insert into reason(Description) values(?)"; 
PreparedStatement statement=conn.prepareStatement(sql);
statement.setString(1,desc);
int update=statement.executeUpdate();
if(update>0)
{
	out.print("One Record Inserted!!");
}
%>
</body>
</html>