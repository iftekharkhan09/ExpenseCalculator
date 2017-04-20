
<%@page import="com.src.Model.Name"%>
<%@page import="com.src.Model.Expense"%>
<%@page import="com.src.controller.Expenditure_Calc"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/style_account_tables1.css">
<title>Cash Sheet</title>
</head>
<body>
	<br>
	<br> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
	<a href="Home.jsp">Home</a>&emsp;&emsp;&emsp;
	<a href="Profile.jsp">Profile</a> &emsp;&emsp;&emsp;
	<a href="Createandupdateuser.jsp">Create/Update User</a>
	&emsp;&emsp;&emsp;
	<a href="Addetails.jsp">Add Category/Reasons</a> &emsp;&emsp; &emsp;
	<a href="DataAnalysis.jsp">Data Analysis</a> &emsp;&emsp;&emsp;
	<a href="logout.jsp">Logout</a>
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
String value = request.getParameter("period");
if (value.equals("search_by_period")) {
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
	
	String user=request.getParameter("user");
	String[] splited = user.split("\\s+");
	String first_name = splited[0];
	String last_name = splited[1];
	String s = "select user_id from user inner join name on user.name_id=name.name_id where name.first_name=? and name.last_name=?";
	Connection conn=DBConnector.getDBConnection();
	PreparedStatement statement=conn.prepareStatement(s);
	statement.setString(1,first_name);
	statement.setString(2,last_name);
	ResultSet set=statement.executeQuery();
	int user_id=0;
	while(set.next())
	{
		user_id=set.getInt(1);
	}
	Expenditure_Calc calc=new Expenditure_Calc();
	double common_share= calc.get_common_share(sqldate,sqldate1);
	double individaul_share=calc.getindividual_share(user_id, sqldate,sqldate1);
	String total_amt_spent="select sum(total_price) from expense where date_of_purchase between ? and ? ";
	PreparedStatement prepare=conn.prepareStatement(total_amt_spent);
	prepare.setDate(1, sqldate);
	prepare.setDate(2, sqldate1);
	ResultSet tet=prepare.executeQuery();
	double total=0.0;
	while(tet.next())
	{
	total=tet.getDouble(1);
	}
	
	String total_amt_paid_by_the_user="select sum(total_price) from expense where amount_paid_by=? and date_of_purchase between ? and ?";
	PreparedStatement paid_by=conn.prepareStatement(total_amt_paid_by_the_user);
	paid_by.setInt(1,user_id);
	paid_by.setDate(2, sqldate);
	paid_by.setDate(3, sqldate1);
	ResultSet fat=paid_by.executeQuery();
	double paid=0.0;
	while(fat.next())
	{
		paid=fat.getDouble(1);
	}
%>
	<div id="page-wrap">
		<table border="1" width="80%" cellpadding="0">
			<thead>
				<tr>
					<th colspan="3">Cash Sheet Data</th>
				</tr>
			</thead>
			<tbody>
				<TR>
					<TH>Period :</TH>
					<td><%= sqldate %> to <%= sqldate1 %></td>
				</TR>
				<TR>
					<TH>User :</TH>
					<td><%= user%></td>
				</TR>

				<TR>
					<TH>Total Amount Spend during the period:</TH>
					<td><%= total %></td>
				</TR>
				<TR>
					<TH>Common Amount Spend :</TH>
					<td><%= common_share %></td>
				</TR>
				<TR>
					<TH>Total Amount paid by the User :</TH>
					<td><%= paid %></td>
				</TR>
				<TR>
			</tbody>
		</table>
		</div>
	</form>
	<br>
	<b><centre>Credit Details :</centre></b>
	<div id="page-wrap">
		<table border="1" width="80%" cellpadding="0">
		<TR>
			<TH>Date Of Purchase</TH>
			<TH>Item Name</TH>
			<TH>Crediter Name</TH>
			<TH>Amount(In Rupees)</TH>
			<TH></TH>
		</TR>
	<%
	String get_credit_details="select trans.date_of_purchase,it.Description,trans.amount_taken_by,trans.amount,trans.transaction_id from transaction trans inner join expense exp on exp.expense_id=trans.expense_id inner join item it on exp.item_id=it.item_id where trans.amount_paid_by=? and trans.amount_taken_by!=? and is_paid='N' and trans.date_of_purchase between ? and ? order by trans.date_of_purchase";
	PreparedStatement credit_statement=conn.prepareStatement(get_credit_details);
	credit_statement.setInt(1,user_id);
	credit_statement.setInt(2,user_id);
	credit_statement.setDate(3, sqldate);
	credit_statement.setDate(4, sqldate1);
    ResultSet sty=credit_statement.executeQuery();
	while(sty.next()){%>
		<TR>
			<td><%=sty.getDate(1) %></td>
			<td><%=sty.getString(2) %></td>
			
			<%String getname="select first_name from name where name_id in(select name_id from user where user_id=?)";
			PreparedStatement statament_name=conn.prepareStatement(getname);
			statament_name.setInt(1, sty.getInt(3));
			ResultSet name_set=statament_name.executeQuery();

			String user_name=null;
			while(name_set.next())
			{
				user_name=name_set.getString(1);
			}
			%>
			<td><%=user_name %></td>
			<td><%=sty.getDouble(4) %></td>
			<td><a href="amount_paid.jsp?id=<%=sty.getInt(5)%>">Close Balance</a>
	</TR>
	<% }
	String get_credit_details1="select trans.date_of_purchase,it.Description,trans.amount_taken_by,trans.amount,trans.transaction_id from transaction trans inner join expense exp on exp.expense_id=trans.expense_id inner join item it on exp.item_id=it.item_id where trans.amount_paid_by=? and trans.amount_taken_by!=? and is_paid='Y' and trans.date_of_purchase between ? and ? order by trans.date_of_purchase";
	PreparedStatement credit_statement1=conn.prepareStatement(get_credit_details1);
	credit_statement1.setInt(1,user_id);
	credit_statement1.setInt(2,user_id);
	credit_statement1.setDate(3, sqldate);
	credit_statement1.setDate(4, sqldate1);
    ResultSet sty1=credit_statement1.executeQuery();
	while(sty1.next()){%>
		<TR>
			<td><%=sty1.getDate(1) %></td>
			<td><%=sty1.getString(2) %></td>
			
			<%String getname1="select first_name from name where name_id in(select name_id from user where user_id=?)";
			PreparedStatement statament_name1=conn.prepareStatement(getname1);
			statament_name1.setInt(1, sty1.getInt(3));
			ResultSet name_set1=statament_name1.executeQuery();

			String user_name1=null;
			while(name_set1.next())
			{
				user_name1=name_set1.getString(1);
			}
			%>
			<td><%=user_name1 %></td>
			<td><%=sty1.getDouble(4) %></td>
			<td><b>The Amount has been already Paid!!</b></td>
	</TR>
	<% }%>
	</center>
		</TABLE>	
<%}
else
{
	String month=request.getParameter("month");
	String year=request.getParameter("year");
	String user=request.getParameter("user");
	String[] splited = user.split("\\s+");
	String first_name = splited[0];
	String last_name = splited[1];
	String s = "select user_id from user inner join name on user.name_id=name.name_id where name.first_name=? and name.last_name=?";
	Connection conn=DBConnector.getDBConnection();
	PreparedStatement statement=conn.prepareStatement(s);
	statement.setString(1,first_name);
	statement.setString(2,last_name);
	ResultSet set=statement.executeQuery();
	int user_id=0;
	while(set.next())
	{
		user_id=set.getInt(1);
	}
	String mo="select id from month where name=?";
	PreparedStatement st=conn.prepareStatement(mo);
	st.setString(1,month);
	ResultSet set5=st.executeQuery();
	String month1=null;
	while(set5.next())
	{
	month1=set5.getString(1);	
	}
	Expenditure_Calc calc=new Expenditure_Calc();
	double common_share= calc.get_common_share(month1, year);
	 String date = year + "-" + month1 + "-%";
	double individaul_share=calc.getindividual_share(user_id, month1, year);
	String total_amt_spent="select sum(total_price) from expense where date_of_purchase like ?";
	PreparedStatement prepare=conn.prepareStatement(total_amt_spent);
	prepare.setString(1, date);
	ResultSet tet=prepare.executeQuery();
	double total=0.0;
	while(tet.next())
	{
	total=tet.getDouble(1);
	}
	
	String total_amt_paid_by_the_user="select sum(total_price) from expense where amount_paid_by=? and date_of_purchase like ?";
	PreparedStatement paid_by=conn.prepareStatement(total_amt_paid_by_the_user);
	paid_by.setInt(1,user_id);
	paid_by.setString(2, date);
	ResultSet fat=paid_by.executeQuery();
	double paid=0.0;
	while(fat.next())
	{
		paid=fat.getDouble(1);
	}
%>
	<center>
		<table border="1" width="80%" cellpadding="0">
			<thead>
				<tr>
					<th colspan="3">Cash Sheet Data</th>
				</tr>
			</thead>
			<tbody>
				<TR>
					<TH>Period :</TH>
					<td><%= month %> , <%= year %></td>
				</TR>
				<TR>
					<TH>User :</TH>
					<td><%= user%></td>
				</TR>

				<TR>
					<TH>Total Amount Spend during the period:</TH>
					<td><%= total %></td>
				</TR>
				<TR>
					<TH>Common Amount Spend :</TH>
					<td><%= common_share %></td>
				</TR>
				<TR>
					<TH>Total Amount paid by the User :</TH>
					<td><%= paid %></td>
				</TR>
				<TR>
			</tbody>
		</table>
	</center>
	</form>
	<br>
	<b><centre>Credit Details :</centre></b>
	<center>
		<table border="1" width="80%" cellpadding="0">
		<TR>
			<TH>Date Of Purchase</TH>
			<TH>Item Name</TH>
			<TH>Crediter Name</TH>
			<TH>Amount(In Rupees)</TH>
			<TH></TH>
		</TR>
	<%
	String get_credit_details="select trans.date_of_purchase,it.Description,trans.amount_taken_by,trans.amount,trans.transaction_id from transaction trans inner join expense exp on exp.expense_id=trans.expense_id inner join item it on exp.item_id=it.item_id where trans.amount_paid_by=? and trans.amount_taken_by!=? and is_paid='N' and trans.date_of_purchase like ? order by trans.date_of_purchase";
	PreparedStatement credit_statement=conn.prepareStatement(get_credit_details);
	credit_statement.setInt(1,user_id);
	credit_statement.setInt(2,user_id);
	credit_statement.setString(3, date);
    ResultSet sty=credit_statement.executeQuery();
	while(sty.next()){%>
		<TR>
			<td><%=sty.getDate(1) %></td>
			<td><%=sty.getString(2) %></td>
			
			<%String getname="select first_name from name where name_id in(select name_id from user where user_id=?)";
			PreparedStatement statament_name=conn.prepareStatement(getname);
			statament_name.setInt(1, sty.getInt(3));
			ResultSet name_set=statament_name.executeQuery();

			String user_name=null;
			while(name_set.next())
			{
				user_name=name_set.getString(1);
			}
			%>
			<td><%=user_name %></td>
			<td><%=sty.getDouble(4) %></td>
			<td><a href="amount_paid.jsp?id=<%=sty.getInt(5)%>">Close Balance</a>
	</TR>
	<% }
	String get_credit_details1="select trans.date_of_purchase,it.Description,trans.amount_taken_by,trans.amount,trans.transaction_id from transaction trans inner join expense exp on exp.expense_id=trans.expense_id inner join item it on exp.item_id=it.item_id where trans.amount_paid_by=? and trans.amount_taken_by!=? and is_paid='Y' and exp.date_of_purchase like ? order by trans.date_of_purchase";
	PreparedStatement credit_statement1=conn.prepareStatement(get_credit_details1);
	credit_statement1.setInt(1,user_id);
	credit_statement1.setInt(2,user_id);
	credit_statement1.setString(3, date);
    ResultSet sty1=credit_statement1.executeQuery();
	while(sty1.next()){%>
		<TR>
			<td><%=sty1.getDate(1) %></td>
			<td><%=sty1.getString(2) %></td>
			
			<%String getname1="select first_name from name where name_id in(select name_id from user where user_id=?)";
			PreparedStatement statament_name1=conn.prepareStatement(getname1);
			statament_name1.setInt(1, sty1.getInt(3));
			ResultSet name_set1=statament_name1.executeQuery();

			String user_name1=null;
			while(name_set1.next())
			{
				user_name1=name_set1.getString(1);
			}
			%>
			<td><%=user_name1 %></td>
			<td><%=sty1.getDouble(4) %></td>
			<td><b>The Amount has been already Paid!!</b></td>
	</TR>
	<% }}%>
	</center>
		</TABLE>
	
</body>
</html>