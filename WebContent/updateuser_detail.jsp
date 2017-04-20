<%@page import="com.src.controller.DBConnector"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@page import="com.src.Model.*" %>
<%@page import="com.src.controller.*" %>
<%@page import="java.sql.*" %>
</head>
<jsp:useBean id="name" class="com.src.Model.Name"></jsp:useBean>
<jsp:setProperty property="*" name="name"/>
<jsp:useBean id="gender" class="com.src.Model.Gender"></jsp:useBean>
<jsp:setProperty property="*" name="gender"/>
<jsp:useBean id="user" class="com.src.Model.User"></jsp:useBean>
<jsp:setProperty property="*" name="user"/>
<body>
<%
Connection conn=DBConnector.getDBConnection();
String email=user.getEmail();
String username=user.getUsername();
String sql="update user set email=? where username=?";
PreparedStatement statement=conn.prepareStatement(sql);
statement.setString(1,user.getEmail());
statement.setString(2,user.getUsername());
int update=statement.executeUpdate();
if(update>0)
{
	out.print("Successfully Updated!!");
}
%>
</body>
</html>