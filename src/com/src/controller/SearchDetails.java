package com.src.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;



public class SearchDetails {

	public void date_of_purcharse(String dop_from,String dop_to) throws SQLException, ParseException
	{
		String date_of_purchase_from=dop_from;
		SimpleDateFormat simple=new SimpleDateFormat("MM/dd/yyyy");
		java.util.Date date=simple.parse(date_of_purchase_from);
		java.sql.Date sqldate=new java.sql.Date(date.getTime());
		
		String date_of_purchase_to=dop_to;
		SimpleDateFormat simple1=new SimpleDateFormat("MM/dd/yyyy");
		java.util.Date date1=simple.parse(date_of_purchase_to);
		java.sql.Date sqldate1=new java.sql.Date(date.getTime());
		
		Connection conn=null;
		conn=DBConnector.getDBConnection();
		String sql="select exp.Date_Of_purchase,it.Description,cat.Description,exp.quantity_purchased,it.measurement_unit,exp.Total_price,exp.Amount__by,exp.exclude,exp.Updated_time,exp.Updated_by,exp.comments from expense exp inner join item it on exp.item_id=it.item_id inner join category cat on cat.category_id=it.category_id where exp.date_of_purchase between ? and ?";
		PreparedStatement statement=conn.prepareStatement(sql);
		statement.setDate(1,sqldate);
		statement.setDate(2, sqldate1);
		
	}
	
}
