<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Settle Payments</title>
<%@page import="java.sql.Connection" %>
</head>
<body>
<TABLE BORDER="1">
		<TR>
			<TH>Date Of Purchase</TH>
			<TH>Item Name</TH>
			<TH>Crediter Name</TH>
			<TH>Amount(In Rupees)</TH>
			<TH></TH>
		</TR>
	<%
	Connection conn=DBConnector.getDBConnection();
	String get_credit_details="select trans.date_of_purchase,it.Description,trans.amount_taken_by,trans.amount from transaction trans inner join expense exp on exp.expense_id=trans.expense_id inner join item it on exp.item_id=it.item_id where trans.amount_paid_by=?";
	PreparedStatement credit_statement=conn.prepareStatement(get_credit_details);
	credit_statement.setInt(1,get_user_id);
	
	
		%>
		
		
		</TABLE>
</body>
</html>