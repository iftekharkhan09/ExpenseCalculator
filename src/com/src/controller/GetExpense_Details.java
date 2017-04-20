package com.src.controller;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.src.Model.Expense;


public class GetExpense_Details {

	public  boolean save_expense_details(Expense exp,int item_id,int paid_by,int updated_by,int reason_id,String roott,double individual_share)
			throws SQLException, ParseException {
		Connection conn = null;
		conn = DBConnector.getDBConnection();
		String date_of_purchase=exp.getDate_of_purchase();
		SimpleDateFormat simple=new SimpleDateFormat("MM/dd/yyyy");
		java.util.Date date=simple.parse(date_of_purchase);
		java.sql.Date sqldate=new java.sql.Date(date.getTime());
		String sql = "insert into expense(item_id,Date_Of_purchase,exclude,quantity_purchased,Amount_paid_by,Total_price,Updated_by,comments,Reason_id,individual_share) values(?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement statement = conn.prepareStatement(sql);
		statement.setInt(1,item_id);
		statement.setDate(2,sqldate);
		statement.setDouble(4,exp.getQuantity_purchased());
		statement.setInt(5,paid_by);
		statement.setDouble(6,exp.getTotal_price());
		statement.setInt(7,updated_by);
		statement.setString(8,exp.getComments());
		statement.setInt(9,reason_id);
		statement.setString(3,roott);
		statement.setDouble(10, individual_share);
		int rs = statement.executeUpdate();
		if (rs > 0) {
			return true;
		}
		return false;
	}
	
	public static boolean insert_data(int expense_id,int paid_by,int taken_by,java.sql.Date date_of_purchase,double individual_share) throws SQLException
	{
		Connection conn=DBConnector.getDBConnection();
		
		String insert_data="insert into transaction(amount_paid_by,amount_taken_by,date_of_purchase,expense_id,amount) values(?,?,?,?,?)";
		PreparedStatement st=conn.prepareStatement(insert_data);
		st.setInt(1, paid_by);
		st.setInt(2, taken_by);
        st.setDate(3,date_of_purchase);
        st.setInt(4, expense_id);
        st.setDouble(5, individual_share);
		int data=st.executeUpdate();
		System.out.println(data);
		if(data>0)
		{
			return true;
		}
		return false;
	}
	
	
}