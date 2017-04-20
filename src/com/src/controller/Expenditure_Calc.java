package com.src.controller;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class Expenditure_Calc {
	public static void main(String[] args) throws SQLException {
		Expenditure_Calc calc = new Expenditure_Calc();
	}

	public double get_common_share(String month,String year) throws SQLException {
		    Connection conn = DBConnector.getDBConnection();
		    String date = year + "-" + month + "-%";
		    double common_share = 0.0;
			String sql = "select sum(individual_share) from expense where exclude is NULL and date_of_purchase like ?";
			PreparedStatement statement2 = conn.prepareStatement(sql);
			statement2.setString(1, date);
			ResultSet rs = statement2.executeQuery();
			while (rs.next()) {
				common_share = rs.getDouble(1);
			}
			return common_share;
		}
	public double getindividual_share(int user_id, String month, String year)
			throws SQLException {
		Connection conn = DBConnector.getDBConnection();
		String user_start_date="select start_date from user where user_id=?";
		PreparedStatement st=conn.prepareStatement(user_start_date);
		st.setInt(1,user_id);
		ResultSet rs=st.executeQuery();
		Date start_date=null;
		while(rs.next())
		{
			start_date=rs.getDate(1);
		}
		String date = year + "-" + month + "-%";
		String chk_exclude_for_his_name = "select na.first_name from name na inner join user us on us.name_id=na.name_id where us.user_id=?";
		PreparedStatement statement1=conn.prepareStatement(chk_exclude_for_his_name);
		statement1.setInt(1,user_id);
		ResultSet set1=statement1.executeQuery();
		String first_name=null;
		while(set1.next())
		{
			first_name=set1.getString(1);
		}
		String sql2="select sum(Individual_share) from expense where date_of_purchase like ? and date_of_purchase>=? and exclude NOT like ?";
		String f_name="%"+first_name+"%";
		PreparedStatement statement3=conn.prepareStatement(sql2);
		statement3.setString(1,date);
		statement3.setDate(2,start_date);
		statement3.setString(3,f_name);
		ResultSet set4=statement3.executeQuery();
		double expense1=0.0;
		while(set4.next())
		{
		expense1=set4.getDouble(1);
		}
		System.out.println(expense1);
		return expense1;
	}
	public double get_common_share(java.sql.Date start_dop,java.sql.Date end_dop) throws SQLException {
	    Connection conn = DBConnector.getDBConnection();
	    double common_share = 0.0;
		String sql = "select sum(individual_share) from expense where exclude is NULL and date_of_purchase between ? and ?";
		PreparedStatement statement2 = conn.prepareStatement(sql);
		statement2.setDate(1, start_dop);
		statement2.setDate(2, end_dop);
		ResultSet rs = statement2.executeQuery();
		while (rs.next()) {
			common_share = rs.getDouble(1);
		}
		return common_share;
	}
public double getindividual_share(int user_id,java.sql.Date start_dop,java.sql.Date end_dop)
		throws SQLException {
	Connection conn = DBConnector.getDBConnection();
	String user_start_date="select start_date from user where user_id=?";
	PreparedStatement st=conn.prepareStatement(user_start_date);
	st.setInt(1,user_id);
	ResultSet rs=st.executeQuery();
	Date start_date=null;
	while(rs.next())
	{
		start_date=rs.getDate(1);
	}
	String chk_exclude_for_his_name = "select na.first_name from name na inner join user us on us.name_id=na.name_id where us.user_id=?";
	PreparedStatement statement1=conn.prepareStatement(chk_exclude_for_his_name);
	statement1.setInt(1,user_id);
	ResultSet set1=statement1.executeQuery();
	String first_name=null;
	while(set1.next())
	{
		first_name=set1.getString(1);
	}
	String sql2="select sum(Individual_share) from expense where date_of_purchase between ? and ? and exclude NOT like ?";
	String f_name="%"+first_name+"%";
	PreparedStatement statement3=conn.prepareStatement(sql2);
	statement3.setDate(1, start_date);
	statement3.setDate(2, end_dop);
	statement3.setString(3,f_name);
	ResultSet set4=statement3.executeQuery();
	double expense1=0.0;
	while(set4.next())
	{
	expense1=set4.getDouble(1);
	}
	System.out.println(expense1);
	return expense1;
}
	
}