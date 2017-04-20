<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Expense</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/style_account_tables1.css">
</head>
<body>
	<br>
	<br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<a href="Home.jsp">Home</a>&emsp;&emsp;&emsp;
	<a href="Profile.jsp">Profile</a> &emsp;&emsp;&emsp;
	<a href="Createandupdateuser.jsp">Create/Update User</a>
	&emsp;&emsp;&emsp;
	<a href="Addetails.jsp">Add Category/Reasons</a> &emsp;&emsp; &emsp;
	<a href="userSettlement.jsp">Cash Sheet</a> &emsp;&emsp;&emsp;
	<a href="DataAnalysis.jsp">Data Analysis</a> &emsp;&emsp;&emsp;
	<a href="logout.jsp">Logout</a>
	<br>
	<br>
	<br>
	<%@page import="java.sql.*"%>
	<%@page import="java.text.ParseException"%>
	<%@page import="java.text.SimpleDateFormat"%>
	<%@page import="java.sql.ResultSet"%>
	<%@page import="java.sql.Statement"%>
	<%@page import="java.sql.PreparedStatement"%>
	<%@page import="com.src.controller.DBConnector"%>
	<%@page import="java.sql.Connection"%>
	<%
		String value = request.getParameter("search");
	%>
	<%
		if (value.equals("dop")) {
			String dop_from = request.getParameter("date_of_purchase_from");
			String dop_to = request.getParameter("date_of_purchase_to");
			String date_of_purchase_from = dop_from;
			SimpleDateFormat simple = new SimpleDateFormat("MM/dd/yyyy");
			java.util.Date date = simple.parse(date_of_purchase_from);
			java.sql.Date sqldate = new java.sql.Date(date.getTime());

			String date_of_purchase_to = dop_to;
			SimpleDateFormat simple1 = new SimpleDateFormat("MM/dd/yyyy");
			java.util.Date date1 = simple1.parse(date_of_purchase_to);
			java.sql.Date sqldate1 = new java.sql.Date(date1.getTime());
			Connection conn2 = null;
			conn2 = DBConnector.getDBConnection();
			String sql6 = "select exp.expense_id,exp.Date_Of_purchase,it.Description,cat.Description,exp.quantity_purchased,it.measurement_unit,exp.Total_price,exp.Amount_paid_by,exp.exclude,exp.Updated_time,exp.Updated_by,exp.comments from expense exp inner join item it on exp.item_id=it.item_id inner join category cat on cat.category_id=it.category_id where exp.date_of_purchase between ? and ? order by exp.date_of_purchase asc";
			PreparedStatement statement = conn2.prepareStatement(sql6);
			statement.setDate(1, sqldate);
			statement.setDate(2, sqldate1);
			ResultSet resultset4 = statement.executeQuery();
	%>
	<br>
	<B>Search result for the Expense on the Item Purchased Between <%=dop_from%>
		and <%=dop_to%></B>
	<TABLE BORDER="1">
		<TR>
			<TH>Date Of Purchase</TH>
			<TH>Item Name</TH>
			<TH>Category</TH>
			<TH>Quantity</TH>
			<TH>Unit</TH>
			<TH>Amount(Rupees)</TH>
			<TH>Paid By</TH>
			<TH>Exclude</TH>
			<TH>Updated By</TH>
			<TH>Updated On</TH>
			<TH>Comments</TH>
			<TH>Action</TH>
			<TH>Action</TH>
		</TR>
		<br>
		<%
			while (resultset4.next()) {
		%>

		<TR>
			<TD><%=resultset4.getString(2)%></td>
			<TD><%=resultset4.getString(3)%></TD>
			<TD><%=resultset4.getString(4)%></TD>
			<td><%=resultset4.getDouble(5)%></td>
			<%
				int unit_id = resultset4.getInt(6);
						String measurement_query = "select Description from unit where unit_id=?";
						PreparedStatement unit_statement = conn2
								.prepareStatement(measurement_query);
						unit_statement.setInt(1, unit_id);
						ResultSet rd = unit_statement.executeQuery();
						String desc = null;
						while (rd.next()) {
							desc = rd.getString(1);
						}
			%>
			<td><%=desc%></td>
			<td><%=resultset4.getDouble(7)%></td>

			<%
				int paid_by_id = resultset4.getInt(8);
						String paid_by = "select concat(first_name,' ',last_name) from name inner join user on name.name_id=user.name_id where user.user_id=?";
						PreparedStatement sty = conn2.prepareStatement(paid_by);
						sty.setInt(1, paid_by_id);
						ResultSet set3 = sty.executeQuery();
						String userr = null;
						while (set3.next()) {
							userr = set3.getString(1);
						}
			%>


			<td><%=userr%></td>
			<td><%=resultset4.getString(9)%></td>


			<%
				int staff_id = resultset4.getInt(11);
						String updated_by = "select concat(first_name,' ',last_name) from name inner join Staff on name.name_id=staff.name_id where staff.staff_id=?";
						PreparedStatement styy = conn2.prepareStatement(updated_by);
						styy.setInt(1, staff_id);
						ResultSet sun = styy.executeQuery();
						String stafff = null;
						while (sun.next()) {
							stafff = sun.getString(1);
						}
			%>
			<td><%=stafff%></td>
			<td><%=resultset4.getDate(10)%></td>
			<td><%=resultset4.getString(12)%></td>
			<TD><a href="Update_expense.jsp?id=<%=resultset4.getString(1)%>">Update</a>
			</td>
			<TD><a href="delete_expense.jsp?id=<%=resultset4.getString(1)%>">Delete</a>
			</TD>
		</TR>
		<%
			}
			}
		%>
	</TABLE>
	<%
		if (value.equals("upo")) {
			String up_from = request.getParameter("updated_on_from");
			String up_to = request.getParameter("updated_on_to");
			String updated_on_from = up_from;
			SimpleDateFormat simple2 = new SimpleDateFormat("MM/dd/yyyy");
			java.util.Date date3 = simple2.parse(updated_on_from);
			java.sql.Date sqldate2 = new java.sql.Date(date3.getTime());

			String updated_on_to = up_to;
			SimpleDateFormat simple3 = new SimpleDateFormat("MM/dd/yyyy");
			java.util.Date date4 = simple3.parse(updated_on_to);
			java.sql.Date sqldate3 = new java.sql.Date(date4.getTime());

			Connection conn3 = null;
			conn3 = DBConnector.getDBConnection();
			String sql7 = "select exp.expense_id,exp.Date_Of_purchase,it.Description,cat.Description,exp.quantity_purchased,it.measurement_unit,exp.Total_price,exp.Amount_paid_by,exp.exclude,exp.Updated_time,exp.Updated_by,exp.comments from expense exp inner join item it on exp.item_id=it.item_id inner join category cat on cat.category_id=it.category_id where exp.updated_time between ? and ? order by exp.date_of_purchase asc";
			PreparedStatement statement1 = conn3.prepareStatement(sql7);
			statement1.setDate(1, sqldate2);
			statement1.setDate(2, sqldate3);
			ResultSet resultset5 = statement1.executeQuery();
	%>
	<br>
	<B>Search result for the Expense on the Item Updated Between <%=up_from%>
		and <%=up_to%></B>
	<div id="page-wrap">
		<TABLE BORDER="1">
			<TR>
				<TH>Date Of Purchase</TH>
				<TH>Item Name</TH>
				<TH>Category</TH>
				<TH>Quantity</TH>
				<TH>Unit</TH>
				<TH>Amount(Rupees)</TH>
				<TH>Paid By</TH>
				<TH>Exclude</TH>
				<TH>Updated By</TH>
				<TH>Updated On</TH>
				<TH>Comments</TH>
				<th>Action</th>
				<TH>Action</TH>
			</TR>
			<%
				while (resultset5.next()) {
			%>

			<TR>
				<TD><%=resultset5.getString(2)%></td>
				<TD><%=resultset5.getString(3)%></TD>
				<TD><%=resultset5.getString(4)%></TD>
				<td><%=resultset5.getDouble(5)%></td>
				<%
					int unit_id = resultset5.getInt(6);
							String measurement_query = "select Description from unit where unit_id=?";
							PreparedStatement unit_statement = conn3
									.prepareStatement(measurement_query);
							unit_statement.setInt(1, unit_id);
							ResultSet rd = unit_statement.executeQuery();
							String desc = null;
							while (rd.next()) {
								desc = rd.getString(1);
							}
				%>
				<td><%=desc%></td>
				<td><%=resultset5.getDouble(7)%></td>
				<%
					int paid_by_id = resultset5.getInt(8);
							String paid_by = "select concat(first_name,' ',last_name) from name inner join user on name.name_id=user.name_id where user.user_id=?";
							PreparedStatement sty = conn3.prepareStatement(paid_by);
							sty.setInt(1, paid_by_id);
							ResultSet set3 = sty.executeQuery();
							String userr = null;
							while (set3.next()) {
								userr = set3.getString(1);
							}
				%>
				<td><%=userr%></td>
				<td><%=resultset5.getString(9)%></td>
				<%
					int staff_id = resultset5.getInt(11);
							String updated_by = "select concat(first_name,' ',last_name) from name inner join Staff on name.name_id=staff.name_id where staff.staff_id=?";
							PreparedStatement styy = conn3.prepareStatement(updated_by);
							styy.setInt(1, staff_id);
							ResultSet sun = styy.executeQuery();
							String stafff = null;
							while (sun.next()) {
								stafff = sun.getString(1);
							}
				%>
				<td><%=stafff%></td>
				<td><%=resultset5.getDate(10)%></td>
				<td><%=resultset5.getString(12)%></td>
				<TD><a
					href="Update_expense.jsp?id=<%=resultset5.getString(1)%>">Update</a>
				</td>
				<TD><a
					href="delete_expense.jsp?id=<%=resultset5.getString(1)%>">Delete</a>
				</TD>
			</TR>
			<%
				}
				}
			%>
		</TABLE>
	</div>
	<%
		if (value.equals("upb")) {
			Connection conn = DBConnector.getDBConnection();
			String staff_id = request.getParameter("updated_by");
			String get_staff_id = "select staff_id from staff where name_id in(select name_id from name where concat(first_name,' ',last_name)=?)";
			PreparedStatement statement_staff = conn
					.prepareStatement(get_staff_id);
			statement_staff.setString(1, staff_id);
			ResultSet s = statement_staff.executeQuery();
			int staff = 0;
			while (s.next()) {
				staff = s.getInt(1);
			}
			String get_exp = "select exp.expense_id,exp.Date_Of_purchase,it.Description,cat.Description,exp.quantity_purchased,it.measurement_unit,exp.Total_price,exp.Amount_paid_by,exp.exclude,exp.Updated_time,exp.Updated_by,exp.comments from expense exp inner join item it on exp.item_id=it.item_id inner join category cat on cat.category_id=it.category_id where exp.Updated_by=? order by exp.date_of_purchase asc";
			PreparedStatement st = conn.prepareStatement(get_exp);
			st.setInt(1, staff);
			ResultSet sed = st.executeQuery();
	%>
	<br>
	<B>Search result for the Expense on the Item Updated Between By <%=staff_id%></B>
	<div id="page-wrap">
		<TABLE BORDER="1">
			<TR>
				<TH>Date Of Purchase</TH>
				<TH>Item Name</TH>
				<TH>Category</TH>
				<TH>Quantity</TH>
				<TH>Unit</TH>
				<TH>Amount(Rupees)</TH>
				<TH>Paid By</TH>
				<TH>Exclude</TH>
				<TH>Updated By</TH>
				<TH>Updated On</TH>
				<TH>Comments</TH>
				<th>Action</th>
				<TH>Action</TH>
			</TR>

			<%
				while (sed.next()) {
			%>

			<TR>
				<TD><%=sed.getString(2)%></td>
				<TD><%=sed.getString(3)%></TD>
				<TD><%=sed.getString(4)%></TD>
				<td><%=sed.getDouble(5)%> <%
 	int unit_id = sed.getInt(6);
 			String measurement_query = "select Description from unit where unit_id=?";
 			PreparedStatement unit_statement = conn
 					.prepareStatement(measurement_query);
 			unit_statement.setInt(1, unit_id);
 			ResultSet rd = unit_statement.executeQuery();
 			String desc = null;
 			while (rd.next()) {
 				desc = rd.getString(1);
 			}
 %>
				<td><%=desc%></td>
				<td><%=sed.getDouble(7)%></td>
				<%
					int paid_by_id = sed.getInt(8);
							String paid_by = "select concat(first_name,' ',last_name) from name inner join user on name.name_id=user.name_id where user.user_id=?";
							PreparedStatement sty = conn.prepareStatement(paid_by);
							sty.setInt(1, paid_by_id);
							ResultSet set3 = sty.executeQuery();
							String userr = null;
							while (set3.next()) {
								userr = set3.getString(1);
							}
				%>
				<td><%=userr%></td>
				<td><%=sed.getString(9)%></td>
				<%
					int staff_idd = sed.getInt(11);
							String updated_by = "select concat(first_name,' ',last_name) from name inner join Staff on name.name_id=staff.name_id where staff.staff_id=?";
							PreparedStatement styy = conn.prepareStatement(updated_by);
							styy.setInt(1, staff_idd);
							ResultSet sun = styy.executeQuery();
							String stafff = null;
							while (sun.next()) {
								stafff = sun.getString(1);
							}
				%>
				<td><%=stafff%></td>
				<td><%=sed.getDate(10)%></td>
				<td><%=sed.getString(12)%></td>
				<TD><a href="Update_expense.jsp?id=<%=sed.getString(1)%>">Update</a>
				</td>
				<TD><a href="delete_expense.jsp?id=<%=sed.getString(1)%>">Delete</a>
				</TD>
			</TR>
			<%
			}
			}
		%>
		</TABLE>
	</div>
</body>
</html>