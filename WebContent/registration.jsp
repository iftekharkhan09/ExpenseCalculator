<%@page import="com.src.controller.DBConnector"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Staff Registration</title>
</head>
<body>
<%@page import="java.sql.*" %>
<jsp:useBean id="staff" class="com.src.Model.Staff">
</jsp:useBean>
<jsp:setProperty property="*" name="staff"/>
<jsp:useBean id="name" class="com.src.Model.Name"></jsp:useBean>
<jsp:setProperty property="*" name="name"/>
<jsp:useBean id="gender" class="com.src.Model.Gender"></jsp:useBean>
<jsp:setProperty property="*" name="gender"/>
<%String IPaddress=request.getRemoteAddr();%>
<%Connection conn=null;
conn=DBConnector.getDBConnection();
String sql="select name_id from name where first_name=? and last_name=?";
PreparedStatement state=conn.prepareStatement(sql);
state.setString(1,name.getFirst_name());
state.setString(2,name.getLast_name());
ResultSet rs=state.executeQuery();
int name_id=0;
while(rs.next())
{
	name_id=rs.getInt(1);
}
if(name_id>0)
{
	//do nothing..
}
else
{
	String sql2="insert into name(first_name,last_name)values(?,?)";
	PreparedStatement stateme=conn.prepareStatement(sql2);
	stateme.setString(1,name.getFirst_name());
	stateme.setString(2,name.getLast_name());
	int rs1=stateme.executeUpdate();
	if(rs1>0)
	{
		String sql3="select name_id from name where first_name=? and last_name=?";
		PreparedStatement statemmm=conn.prepareStatement(sql);
		statemmm.setString(1,name.getFirst_name());
		statemmm.setString(2,name.getLast_name());
		ResultSet rss=state.executeQuery();
		while(rss.next())
		{
			name_id=rss.getInt(1);
		}
	}
	
} 
String gen=gender.getGender();
String sqll="select gender_id from gender where description=?";
PreparedStatement stat=conn.prepareStatement(sqll);
stat.setString(1,gen);
ResultSet result=stat.executeQuery();
int gen_id=0;
while(result.next())
{
   gen_id=result.getInt(1);	
}

String sql1="insert into staff(ipaddress,user_name,password,name_id,gender_id,email) values(?,?,?,?,?,?)";
PreparedStatement statement=conn.prepareStatement(sql1);
statement.setString(1,IPaddress);
statement.setString(2,staff.getUsername());
statement.setString(3,staff.getPassword());
statement.setInt(4,name_id);
statement.setInt(5,gen_id);
statement.setString(6,staff.getEmail());
int rs6=statement.executeUpdate();
if(rs6>0)
{
	%>
	
	<% response.sendRedirect("Index.jsp");
	}
else
	out.print("Fail");
%>
</body>
</html>