<%@page import="com.sun.jndi.cosnaming.CNNameParser"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset='UTF-8'>
<title>Manage Account</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/style_account_tables1.css">
</head>
<body>
	<br>
	<br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	&emsp;&emsp;&emsp;
	<a href="Home.jsp">Home</a>&emsp;&emsp;&emsp;
	<a href="Profile.jsp">Profile</a> &emsp;&emsp;&emsp;
	<a href="Createandupdateuser.jsp">Create/Update User</a>
	&emsp;&emsp;&emsp;
	<a href="Addetails.jsp">Add Category/Reasons</a> &emsp;&emsp; &emsp;
	<a href="SearchData.jsp">Search Data</a> &emsp;&emsp;&emsp;
	<a href="userSettlement.jsp">Cash Sheet</a> &emsp;&emsp;&emsp;
	<a href="DataAnalysis.jsp">Data Analysis</a> &emsp;&emsp;&emsp;
	<a href="logout.jsp">Logout</a>
	<br>
	<br>
	<h1>Staff Account Info Page</h1>
	<%
		Connection conn = DBConnector.getDBConnection();
		String sql = "select count(*) from Staff where is_admin='N'";
		Statement statement = conn.createStatement();
		ResultSet resultt = statement.executeQuery(sql);
		int count = 0;
		while (resultt.next()) {
			count = resultt.getInt(1);
		}
		if (count == 0) {
			out.print("No records Found!!!");
			//conn.close();
		} else {
			Connection connection = DBConnector.getDBConnection();
			String print_staff = "select st.staff_id,st.user_name,na.first_name,na.last_name,st.unsuccessful_login_attempts from staff st inner join name na on na.name_id=st.name_id where blocked='Y'";
			Statement print_staff_statement = connection.createStatement();
			ResultSet set1 = statement.executeQuery(print_staff);
	%>
	<div id="page-wrap">
		<table border="6px" cellspacing="10px" cellpadding="10px">
			<TR>
				<TH>Username</TH>
				<TH>First Name</TH>
				<th>Last Name</th>
				<TH>No Of Unsuccessful Login Attempts</TH>
				<TH>Action</TH>
			</TR>
			<%
				while (set1.next()) {
			%>
			<TR>
				<TD><%=set1.getString(2)%></td>
				<TD><%=set1.getString(3)%></TD>
				<td><%=set1.getString(4)%></td>
				<td><%=set1.getInt(5)%></td>
				<Td><a href="update.jsp?id=<%=set1.getString(1)%>">UnBlock
						Account</a></td>
			</TR>
			<%
				}
					String print_staff_not_bloacked = "select st.staff_id,st.user_name,na.first_name,na.last_name,st.unsuccessful_login_attempts from staff st inner join name na on na.name_id=st.name_id and blocked='N' and is_admin='N'";
					Statement statementt = connection.createStatement();
					ResultSet result_set = statementt
							.executeQuery(print_staff_not_bloacked);
			%>
			<%
				while (result_set.next()) {
			%>
			<TR>
				<TD><%=result_set.getString(2)%></td>
				<TD><%=result_set.getString(3)%></TD>
				<td><%=result_set.getString(4)%></td>
				<td><%=result_set.getInt(5)%></td>
				<Td><a
					href="update_unblock.jsp?id=<%=result_set.getString(1)%>">Block
						Account</a></td>

			</TR>
			<%
				}

				}
			%>
		</TABLE>
	</div>
	<br>
	<h1>User Account Info Page</h1>
	<%
		Connection conn1 = DBConnector.getDBConnection();
		String sql1 = "select count(*) from user";
		Statement statement1 = conn1.createStatement();
		ResultSet result1 = statement1.executeQuery(sql1);
		int count1 = 0;
		while (result1.next()) {
			count1 = result1.getInt(1);
		}
		if (count1 == 0) {
			out.print("No records Found!!!");
			//conn.close();
		} else {
			Connection connection = DBConnector.getDBConnection();
			String print_staff = "select st.user_id,st.username,na.first_name,na.last_name,st.start_date,leaving_date from user st inner join name na on na.name_id=st.name_id where is_active='N'";
			Statement print_staff_statement = connection.createStatement();
			ResultSet set1 = statement.executeQuery(print_staff);
	%>
	<div id="page-wrap">
		<table border="6px" cellspacing="10px" cellpadding="10px">
			<TR>
				<TH>Username</TH>
				<TH>First Name</TH>
				<th>Last Name</th>
				<TH>Start Date</TH>
				<TH>Leaving Date</TH>
				<TH>Info</TH>
			</TR>
			<%
				while (set1.next()) {
			%>
			<TR>
				<TD><%=set1.getString(2)%></td>
				<TD><%=set1.getString(3)%></TD>
				<td><%=set1.getString(4)%></td>
				<td><%=set1.getDate(5)%></td>
				<td><%=set1.getDate(6)%></td>
				<td><strong>The Account is Closed!!</strong></td>
			</TR>
			<%
				}
			%>
			<%
				String print_staff_not_blocked = "select st.user_id,st.username,na.first_name,na.last_name,st.start_date,leaving_date from user st inner join name na on na.name_id=st.name_id where is_active='Y'";
					Statement statementt = connection.createStatement();
					ResultSet result_set = statementt
							.executeQuery(print_staff_not_blocked);
			%>
			<%
				while (result_set.next()) {
			%>
			<TR>
				<TD><%=result_set.getString(2)%></td>
				<TD><%=result_set.getString(3)%></TD>
				<td><%=result_set.getString(4)%></td>
				<td><%=result_set.getDate(5)%></td>
				<td><%=result_set.getDate(6)%>
				<Td><a
					href="update_unblock_user.jsp?id=<%=result_set.getString(1)%>">Close
						A/C</a></td>
			</TR>
			<%
				}

				}
			%>
		</TABLE>
	</div>
</body>
</html>