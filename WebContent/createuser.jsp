<%@page import="com.src.controller.DBConnector"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%@page import="com.src.Model.*" %>
<%@page import="com.src.controller.*" %>
<%@page import="java.sql.*" %>
</head>
<jsp:useBean id="name" class="com.src.Model.Name"></jsp:useBean>
<jsp:setProperty property="*" name="name"/>
<jsp:useBean id="gender" class="com.src.Model.Gender"></jsp:useBean>
<jsp:setProperty property="*" name="gender"/>
<jsp:useBean id="user" class="com.src.Model.User"></jsp:useBean>
<jsp:setProperty property="*" name="user"/>
<body>
<%
Connection conn=DBConnector.getDBConnection();
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
String sql4="insert into user(username,gender_id,email,is_active,name_id) values(?,?,?,?,?)";
PreparedStatement st=conn.prepareStatement(sql4);
st.setString(1,user.getUsername());
st.setInt(2,gen_id);
st.setString(3,user.getEmail());
st.setString(4,"Y");
st.setInt(5,name_id);
int insert=st.executeUpdate();
if(insert>0)
{
	out.print("Your Record Inserted!!");
}
%>
</body>
</html>