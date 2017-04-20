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
Connection conn=null;
conn=DBConnector.getDBConnection();
String sql="select * from exclude";
PreparedStatement statement=conn.prepareStatement(sql);
ResultSet rs=statement.executeQuery();
%>
<Table>
<tr>
<th>Date Of Purchase:</th>
<th>Item Name:</th>
<th>Category</th>
<th>Quantity</th>
<th>Amount(In Rupees)</th>
<th>Paid By</th>
<th>Exclude</th>
<th>Updated On</th>
<th>Comments</th>
</tr>

<%while(rs.next()){ %>
<tr>
<td><%=rs.getString(2) %></td>
<td><%=rs.getString(3) %></td>
<td><%=rs.getString(4) %></td>
<td><%=rs.getDouble(5) %></td>
<td><%=rs.getDouble(6) %></td>
<td><%=rs.getString(7) %></td>
<td><%=rs.getString(8) %></td>
<td><%=rs.getDate(9) %></td>
<td><%=rs.getString(10)%></td>
<td><a href="update.jsp?id=<%=rs.getInt(1)%>"></a>
<td><a href="delete.jsp?id=<%=rs.getInt(1)%>"></a>
<%} %>
<tr>
</Table>
</body>
</html>