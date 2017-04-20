<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Category</title>
</head>
<jsp:useBean id="category" class="com.src.Model.Category"></jsp:useBean>
<jsp:setProperty property="*" name="category"/>
<%
Connection conn=DBConnector.getDBConnection();
String sql="insert into category(Description) values(?)"; 
PreparedStatement statement=conn.prepareStatement(sql);
statement.setString(1,category.getCategory_description());
int update=statement.executeUpdate();
if(update>0)
{
	out.print("One Record Inserted!!");
}
%>

</body>
</html>