
<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/style_account_tables1.css">
<title>Cash Sheet</title>
<script>
	$(function() {
		$("#datepicker").datepicker();
	});
	$(function() {
		$("#datepicker1").datepicker();
	});
	$(function() {
		$("#datepicker2").datepicker();
	});
	$(function() {
		$("#datepicker3").datepicker();
	});
</script>
<script type="text/javascript" language="JavaScript">
	function radioWithText(d) {
		switch (d.value) {
		case "search_by_period":
			document.getElementById('by_period').style.display = "inline";
			document.getElementById('by_month').style.display = "none";

			break;
		case "search_by_month":
			document.getElementById('by_period').style.display = "none";
			document.getElementById('by_month').style.display = "inline";
			break;
		}
	}
</script>
</head>
<body>
	<br>
	<br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<a href="Home.jsp">Home</a>&emsp;&emsp;&emsp;
	<a href="Profile.jsp">Profile</a> &emsp;&emsp;&emsp;
	<a href="Createandupdateuser.jsp">Create/Update User</a>
	&emsp;&emsp;&emsp;
	<a href="Addetails.jsp">Add Category/Reasons</a> &emsp;&emsp; &emsp;
	<a href="SearchData.jsp">Search Data</a> &emsp;&emsp;&emsp;
	<a href="DataAnalysis.jsp">Data Analysis</a> &emsp;&emsp;&emsp;
	<a href="logout.jsp">Logout</a>
	<br>
	<br>
	<%
		Connection conn = DBConnector.getDBConnection();
		String sql = "select name from month";
		Statement statement = conn.createStatement();
		ResultSet rs = statement.executeQuery(sql);

		String sql_year = "select year from year";
		Statement statement2 = conn.createStatement();
		ResultSet rs1 = statement2.executeQuery(sql_year);

		String sql_username = "select concat(first_name,' ',last_name) from name na inner join user us on na.name_id=us.name_id";
		Statement statement3 = conn.createStatement();
		ResultSet rs2 = statement3.executeQuery(sql_username);
	%>
	<h1>
		<strong>Cash Sheet</strong>
	</h1>
	<form method="post" action="cashsheet.jsp">
		<center>
		<div id="page-wrap">
			<table border="1" width="80%" cellpadding="0">
				<thead>
					<tr>
						<th colspan="3">Define Your settlement Period</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="radio" name="period"
							value="search_by_period" onclick="radioWithText(this)"
							checked="checked">Period Range</td>
						<td><input type="radio" name="period" value="search_by_month"
							onclick="radioWithText(this)">Monthly</td>
					</tr>
					<tr>
						<td><span id="by_period" style="display: inline"> From
								:<input type="text" id="datepicker" name="date_of_purchase_from"
								value="" length="12" /> To : <input type="text"
								id="datepicker1" name="date_of_purchase_to" value="" length="12" />
						</span></td>

						<td><span id="by_month" style="display: none">Month :
								<select name="month">
									<%
										while (rs.next()) {
									%>
									<option>
										<%=rs.getString(1)%>
									</option>
									<%
										}
									%>
							</select> Year : <select name="year">
									<%
										while (rs1.next()) {
									%>
									<option>
										<%=rs1.getString(1)%>
									</option>
									<%
										}
									%>
							</select>
						</span></td>


					</tr>
			</table>
			</div>
			<br> <br> <br> Select the User :<select name="user">
				<%
					while (rs2.next()) {
				%>
				<option>
					<%=rs2.getString(1)%>
				</option>
				<%
					}
				%>
			</select> <br> <br> <br>

			<td><input type="submit" value="Generate Cash Sheet"></td>
			</tr>

			</tbody>
			
		</center>
	</form>	
</body>
</html>