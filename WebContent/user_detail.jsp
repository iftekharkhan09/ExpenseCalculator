<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Info</title>
<jsp:useBean id="name" class="com.src.Model.Name"></jsp:useBean>
<jsp:setProperty property="*" name="name"/>
<jsp:useBean id="gender" class="com.src.Model.Gender"></jsp:useBean>
<jsp:setProperty property="*" name="gender"/>
<jsp:useBean id="user" class="com.src.Model.User"></jsp:useBean>
<jsp:setProperty property="*" name="user"/>
<%@page import="java.sql.*" %>
<%@page import="com.src.controller.*" %>
<%@page import="com.src.Model.*" %>
</head>
<body>
<br>
	<br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	&emsp;&emsp;&emsp;
	<a href="Home.jsp">Home</a>&emsp;&emsp;&emsp;
	<a href="Profile.jsp">Profile</a> &emsp;&emsp;&emsp;
	<a href="SearchData.jsp">Search Data</a> &emsp;&emsp;&emsp;
	<a href="userSettlement.jsp">Cash Sheet</a> &emsp;&emsp;&emsp;
	<a href="DataAnalysis.jsp">Data Analysis</a> &emsp;&emsp;&emsp;
	<a href="logout.jsp">Logout</a>
	<br>
	<br>
<%Connection connection=DBConnector.getDBConnection();
String username=user.getUsername();
String sql="select count(*) from user where username=?";
PreparedStatement statement=connection.prepareStatement(sql);
statement.setString(1,username);
int count=0;
ResultSet set=statement.executeQuery();
while(set.next())
{
	count=set.getInt(1);
}
if(count==0)
{
	out.println("User Not Found!!");
}
else
	{
	String sql2="select st.user_id,st.username,na.first_name,na.last_name,st.email,st.start_date from user st inner join name na on na.name_id=st.name_id where username=?";
	PreparedStatement st=connection.prepareStatement(sql2);
	st.setString(1,user.getUsername());
	ResultSet sett=st.executeQuery();
while(sett.next())
{
	%>
	<form name="user_detail" method="post" action="updateuser_detail.jsp">
			<center>
				<table border="1" width="30%" cellpadding="5">
					<thead>
						<tr>
							<th colspan="2">User Information is Shown Below</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>First Name *</td>
							<td><input type="text" name="first_name" value="<%=sett.getString(3) %>" readonly="readonly"/></td>
						</tr>
						<tr>
							<td>Last Name *</td>
							<td><input type="text" name="last_name" value="<%=sett.getString(4) %>" readonly="readonly"/></td>
						</tr>
						<tr>
							<td>Gender *</td>
							<td>Male<input type="radio" id="val" name="gender"
								value="Male" onclick="getgender(this)" checked="checked" />
								Female<input type="radio" id="val1" name="gender" value="Female">
				</td>
						</tr>
						<tr>
							<td>User Name *</td>
							<td><input type="text" name="username" value="<%=sett.getString(2) %>" readonly="readonly"/></td>
						</tr>
						<tr>
							<td>Email *</td>
							<td><input type="text" name="email" value="<%=sett.getString(5) %>" /></td>
						</tr>
						<tr>
							<td><input type="submit" value="Update" /></td>
						</tr>
					</tbody>
				</table>
			</center>
		</form> 
	
<%}} %>
</body>
</html>