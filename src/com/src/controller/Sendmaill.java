package com.src.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Sendmaill {
	public boolean updatepass(String password,String username) throws SQLException
	{
		Date date=new Date();
	Connection conn=null;
	conn=DBConnector.getDBConnection();
	String sql="update staff set password=? where user_name=?";
	PreparedStatement statement3=conn.prepareStatement(sql);
	statement3.setString(1,password);
	statement3.setString(2,username);
	int set=statement3.executeUpdate();
	String getemail="select email from staff where user_name=?";
	PreparedStatement state=conn.prepareStatement(getemail);
	state.setString(1,username);
	ResultSet sett=state.executeQuery();
	String email=null;
	while(sett.next())
	{
		 email=sett.getString(1);
	}
	
	if(set>0)
	{
		MailSender mail=new MailSender();
		String toemail_id=email;
		String subject="Expense Calculator Login Password Change";
		String settext="Your Password has been changed at"+date+"  If you don't remember making this change then please contact the Admin!!";
		mail.sendmail(toemail_id, subject, settext);
		return true;
	}
	return false;

	}
}
