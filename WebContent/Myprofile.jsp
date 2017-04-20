<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Profile Updated</title>
</head>
<body>
	<jsp:useBean id="staff1" class="com.src.Model.Staff"></jsp:useBean>
	<jsp:setProperty property="*" name="staff1" />
	<%@page import="java.sql.*"%>
	<%@page import="com.src.controller.*"%>
	
	<%
		String username = (String) session.getAttribute("username");
		String pass = staff1.getPassword();
		Connection conn = null;
		conn = DBConnector.getDBConnection();
		String chk = "select password from staff where user_name=?";
		PreparedStatement statementt = conn.prepareStatement(chk);
		statementt.setString(1, username);
		ResultSet rss = statementt.executeQuery();
		String password1 = null;
		while (rss.next()) {
			password1 = rss.getString(1);
		}
		if (password1.equals(pass)) {
			
			String mail="select email from staff where user_name=?";
			PreparedStatement st=conn.prepareStatement(mail);
			st.setString(1, username);
			ResultSet s=st.executeQuery();
			String old_email=null;
			while(s.next())
			{
				old_email=s.getString(1);
			}
			
			String subject="Expense calculator Email Update";
			String message="Your Email Id has been updated.If you don't remember making this change then please contact the Admin.Your New Mail Id is "+staff1.getEmail();
			sendmail(old_email, subject, message);
			String sql = "update staff set email=? where user_name=?";
			PreparedStatement state = conn.prepareStatement(sql);
			state.setString(1, staff1.getEmail());
			state.setString(2, username);
			int r = state.executeUpdate();
			statementt.close();
			state.close();
			rss.close();
			conn.close();
			if (r > 0) {
			}
		} else {
			//do nothing print wrong password...
		}
	%>
	<%!
	public void sendmail(String tomail_id,String subject,String message)
	{
		MailSender mailsender=new MailSender();
		mailsender.sendmail(tomail_id, subject, message);
	}
	
	%>
</body>
</html>