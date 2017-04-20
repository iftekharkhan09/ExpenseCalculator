<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Expense</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script>
  $(function() {
    $( "#datepicker" ).datepicker();
  });
  </script>
</head>
<body>
<% 
String id=request.getParameter("id");
Connection con=DBConnector.getDBConnection();
%>
<%
String getdescription_sql="select description from reason";
Statement getdescription_statement=con.createStatement();
ResultSet getdecription_resultset=getdescription_statement.executeQuery(getdescription_sql);
%>
<%
String getcategory_sql="select Description from category";
Statement getcategory_statement=con.createStatement();
ResultSet getcategory_resultset=getcategory_statement.executeQuery(getcategory_sql);
%>
<% 
String getstaffname_sql="select concat(first_name,' ',last_name) from name inner join user on name.name_id=user.name_id where user.is_active='Y'";
Statement getstaffname_statement=con.createStatement();
ResultSet getstaffname_resultset=getstaffname_statement.executeQuery(getstaffname_sql);
%>
<%
String namesql="select first_name from name inner join user on user.name_id=name.name_id where user.is_active='Y'";
Statement name_statement=con.createStatement();
ResultSet name_resultset=name_statement.executeQuery(namesql);
%>

<%
String exclusive="select exclude from expense where expense_id=?";
		PreparedStatement st=con.prepareStatement(exclusive);
st.setString(1,id);
ResultSet s=st.executeQuery();
/* String exclude;
while(s.next())
{
	exclude=s.getString(1);
} */
%>
<%
String get_user_id="select amount_paid_by from expense where expense_id=?";
PreparedStatement user_statement=con.prepareStatement(get_user_id);
user_statement.setString(1, id);
ResultSet get=user_statement.executeQuery();
int user_id=0;
while(get.next())
{
	user_id=get.getInt(1);
}
String paid_by="select concat(first_name,' ',last_name) from name na inner join user us on na.name_id=us.name_id where us.user_id=?";
PreparedStatement f=con.prepareStatement(paid_by);
f.setInt(1, user_id);
ResultSet boy=f.executeQuery();
%>


<%
String getunitsql="select Description from unit";
Statement getunit_statement=con.createStatement();
ResultSet getunit_resultset=getunit_statement.executeQuery(getunitsql);
%>
<% 
String sql="select exp.expense_id,exp.Date_Of_purchase,it.Description,cat.Description,exp.quantity_purchased,it.measurement_unit,exp.Total_price,exp.Amount_paid_by,exp.exclude,exp.Updated_time,exp.Updated_by,exp.comments from expense exp inner join item it on exp.item_id=it.item_id inner join category cat on cat.category_id=it.category_id where exp.expense_id=?";
PreparedStatement statement=con.prepareStatement(sql);
statement.setString(1,id);
ResultSet sete=statement.executeQuery();
%>
<form name="Expense_Data_details" action="update_expenses_data.jsp" method="post">
<table border="6px" cellspacing="10px" cellpadding="10px">
<%while(sete.next()){
%>
<tr>
<td>Date Of Purchase:<input type="text" id="datepicker" name="date_of_purchase" value="<%=sete.getString(2)%>"></td>
<td>Item Name:<input type="text" name="description" value="<%=sete.getString(3)%>"></td>
<td>Category:
<select name="category_description">
<option selected="selected">
<%=sete.getString(4) %>
</option>
<% while(getcategory_resultset.next())
{
	%>
<option>
<%=getcategory_resultset.getString(1)%>
<%}%>
</option>
</select>
</td>
<td>Paid By:
<select name="paid_by">
<%while(boy.next()){ %>
<option selected="selected">
<%=boy.getString(1) %>
<%} %>
</option>
<%while (getstaffname_resultset.next())
{
%>
<option>
<%=getstaffname_resultset.getString(1) %>
<%} %>
</option>
</select>
</td>
<td>Amount Paid:<input type="text" name="total_price" id="total_price" value="<%=sete.getDouble(7)%>"></td>
<td>Quantity:<input type="text" name="quantity_purchased" value="<%=sete.getDouble(5) %>"></td>
<td>Unit:
<select name="unit_decription">
<%while(getunit_resultset.next()){ %>
<option>
<%=getunit_resultset.getString(1) %>
<%} %>
</option>
</select>
</td>
</tr>
<tr>
<tr>
<tr>
<tr>
<td>Exclude:</td>
<%while(name_resultset.next()){ %>
<td><input TYPE="checkbox" name="exclude" >
<%-- VALUE="<%=s.getString(1)%>"checked/> --%>
<%=name_resultset.getString(1) %>
<%} %></td>
<td>Reason : <select name="reason_description">
<%while(getdecription_resultset.next()){ %>
<option>
<%= getdecription_resultset.getString(1)%>
<%} %>
</option>
</select>
</tr>
<tr>
<td>
Comments:<textarea rows="3" cols="25" name="comments" value="<%=sete.getString(12)%>"></textarea>
</td>
</tr>
<tr>
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<td><input type="submit" value="Update" align="middle"></td></tr>
<%
}
%>
</table>
</form>
</body>
</html>