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
<title>User Profile</title>
</head>
<body>
	<br>
	<br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<a href="Home.jsp">Home</a>&emsp;&emsp;&emsp;
	<a href="Createandupdateuser.jsp">Create/Update User</a>
	&emsp;&emsp;&emsp;
	<a href="Addetails.jsp">Add Category/Reasons</a> &emsp;&emsp; &emsp;
	<a href="SearchData.jsp">Search Data</a> &emsp;&emsp;&emsp;
	<a href="userSettlement.jsp">Cash Sheet</a> &emsp;&emsp;&emsp;
	<a href="DataAnalysis.jsp">Data Analysis</a> &emsp;&emsp;&emsp;
	<a href="logout.jsp">Logout</a>
	<br>
	<br>
	<script type="text/javascript">
function validateemail()
{
	var x = document.forms["myprofile"]["email"].value;
	
	if (x == null || x == "") {
		alert("Please enter an Email Id!!");
		return false;
	}

</script>
	<%@page import="com.src.*"%>
	<%
		String username = (String) session.getAttribute("username");
		Connection conn = null;
		conn = DBConnector.getDBConnection();
		String sql = "select na.first_name,na.last_name,st.email,st.user_name from staff st inner join name na on st.name_id=na.name_id where st.user_name=?";
		PreparedStatement statement = conn.prepareStatement(sql);
		statement.setString(1, username);
		ResultSet set = statement.executeQuery();
		while (set.next()) {
	%>
	<form name="myprofile" method="post" action="Myprofile.jsp">
		<center>
			<table border="1" width="30%" cellpadding="5">
				<thead>
					<tr>
						<th colspan="2">Your Profile Information</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>First Name</td>
						<td><input type="text" name="first_name"
							value="<%=set.getString(1)%>" readonly="readonly" /></td>
					</tr>
					<tr>
						<td>Last Name</td>
						<td><input type="text" name="last_name"
							value="<%=set.getString(2)%>" readonly="readonly" /></td>
					</tr>
					<tr>
						<td>Gender</td>
						<td>Male<input type="radio" id="val" name="gender"
							value="Male" onclick="getgender(this)" checked="checked" />
							Female<input type="radio" id="val1" name="gender" value="Female"
							onclick="getgender(this)" />
						</td>
					</tr>
					<tr>
						<td>Email</td>
						<td><input type="text" name="email"
							value="<%=set.getString(3)%>" /></td>
					</tr>
					<tr>
						<td>User Name</td>
						<td><input type="text" name="username"
							value="<%=set.getString(4)%>" readonly="readonly" /></td>
					</tr>
					<tr>
						<td>Enter Current Password</td>
						<td><input type="password" name="password" /></td>
					</tr>
					<tr>
						<td><input type="submit" value="Update" /></td>
						<td><input type="reset" value="Reset" /></td>
					</tr>
					<tr>
						<td colspan="2">Update Password!! <a
							href="updatepassword.jsp">Click Here</a>
						</td>
					</tr>
					<%
							}
						%>
				</tbody>
			</table>
		</center>
	</form>
	</div>
</body>
</html>