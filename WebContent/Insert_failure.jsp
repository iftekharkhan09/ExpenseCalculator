<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert Successful</title>
<%@page import="java.util.List"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.src.Model.*"%>
<script type="text/javascript">
	function validate_data() {
		var a = document.forms["Expense_Data"]["date_of_purchase"].value;
		var b = document.forms["Expense_Data"]["description"].value;
		var c = document.forms["Expense_Data"]["total_price"].value;
		var d = document.forms["Expense_Data"]["quantity_purchased"].value;
		
		
		
		if (a == null || a == "") {
			alert("Please Enter the Date of Purchase");
			return false;
		}
		if (b == null || b == "") {
			alert("Please Enter the Item");
			return false;
		}
		if (c == null || c == "") {
			alert("Please Enter the Amount");
			return false;
		}
		if (d == null || d == "") {
			alert("Please Enter the Quantity Purchased");
			return false;
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">
<script>
	$(function() {
		$("#datepicker").datepicker();
	});
</script>
<%@page import="com.src.controller.*"%>
</head>
<body>
	<br>
	<br>Welcome
	<%
		String username = session.getAttribute("username").toString();
		Connection con = DBConnector.getDBConnection();
		String getname_sql = "select concat(first_name,' ',last_name) from name inner join staff on staff.name_id=name.name_id where staff.user_name=?";
		PreparedStatement getname_statement = con
				.prepareStatement(getname_sql);
		getname_statement.setString(1, username);
		ResultSet getname_resultset = getname_statement.executeQuery();
		while (getname_resultset.next()) {
			out.print(getname_resultset.getString(1) + "!!");
		}
		UserLogin user = new UserLogin();

		Staff staff = (Staff) session.getAttribute("admin");
		boolean user_admin = user.is_admin(staff);
	%>
	<%
		if (user_admin) {
	%>
	&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<a href="admin_page.jsp">Manage Account</a>
	<%
		}
	%>
	&emsp;&emsp;&emsp;
	<a href="Profile.jsp">Profile</a> &emsp;&emsp;&emsp;
	<a href="Createandupdateuser.jsp">Create/Update User</a>
	&emsp;&emsp;&emsp;
	<a href="SearchData.jsp">Search Data</a> &emsp;&emsp;&emsp;
	<a href="userSettlement.jsp">Settlement</a> &emsp;&emsp;&emsp;
	<a href="DataAnalysis.jsp">Data Analysis</a> &emsp;&emsp;&emsp;
	<a href="logout.jsp">Logout</a>
	<br>
	<br>
	<br>
	<%
		String getdescription_sql = "select description from reason";
		Statement getdescription_statement = con.createStatement();
		ResultSet getdecription_resultset = getdescription_statement
				.executeQuery(getdescription_sql);
	%>
	<%
		String getcategory_sql = "select Description from category";
		Statement getcategory_statement = con.createStatement();
		ResultSet getcategory_resultset = getcategory_statement
				.executeQuery(getcategory_sql);
	%>
	<%
		String getstaffname_sql = "select concat(first_name,' ',last_name) from name inner join user on name.name_id=user.name_id where user.is_active='Y'";
		Statement getstaffname_statement = con.createStatement();
		ResultSet getstaffname_resultset = getstaffname_statement
				.executeQuery(getstaffname_sql);
	%>
	<%
		String namesql = "select na.first_name from name na inner join user us on us.name_id=na.name_id where us.is_active='Y'";
		Statement name_statement = con.createStatement();
		ResultSet name_resultset = name_statement.executeQuery(namesql);
	%>
	<%
		String getunitsql = "select Description from unit";
		Statement getunit_statement = con.createStatement();
		ResultSet getunit_resultset = getunit_statement
				.executeQuery(getunitsql);
	%>
	<form name="Expense_Data" action="savedata.jsp" method="post"
		onsubmit="return validate_data()">
		<table border="6px" cellspacing="10px" cellpadding="10px">
			<tr>
				<td>Date Of Purchase:<input type="text" id="datepicker"
					name="date_of_purchase"></td>
				<td>Item Name:<input type="text" name="description"></td>
				<td>Category: <select name="category_description">
						<%
							while (getcategory_resultset.next()) {
						%>
						<option>
							<%=getcategory_resultset.getString(1)%>
							<%
								}
							%>
						</option>
				</select>
				</td>
				<td>Paid By: <select name="paid_by">
						<%
							while (getstaffname_resultset.next()) {
						%>
						<option>
							<%=getstaffname_resultset.getString(1)%>
							<%
								}
							%>
						</option>
				</select>
				</td>
				<td>Amount Paid:<input type="text" name="total_price"
					id="total_price"></td>
				<td>Quantity:<input type="text" name="quantity_purchased"></td>
				<td>Unit: <select name="unit_decription">
						<%
							while (getunit_resultset.next()) {
						%>
						<option>
							<%=getunit_resultset.getString(1)%>
							<%
								}
							%>
						</option>
				</select>
				</td>
			</tr>
			<tr>
			<tr>
			<tr>
			<tr>
				<td>Exclude:</td>
				<%
					while (name_resultset.next()) {
				%>
				<td><input TYPE="checkbox" name="exclude"
					value="<%=name_resultset.getString(1)%>" /> <%=name_resultset.getString(1)%>
					<%
						}
					%></td>
				<td>Reason : <select name="reason_description">
						<%
							while (getdecription_resultset.next()) {
						%>
						<option>
							<%=getdecription_resultset.getString(1)%>
							<%
								}
							%>
						</option>
				</select>
			</tr>
			<tr>
				<td>Comments:<textarea rows="3" cols="25" name="comments"></textarea>
				</td>
			</tr>
			<tr>
				&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
				<td><input type="submit" value="Save" align="middle"></td>
			</tr>
		<tr><td><font color="Red">Error! Insertion Failed. Might be the Date of Purchase has been done before User Start Date!!</font></td></tr> 
			
		</table>
	</form>
</body>
</html>