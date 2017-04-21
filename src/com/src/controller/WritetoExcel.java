package com.src.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;



public class WritetoExcel {

	public static void main(String[] args) throws IOException, SQLException {
		Date date = new Date();
		String simpledateformat = new SimpleDateFormat("dd-MM-yyyy")
				.format(date);
		String pathname = "D:\\Expense_Sheet_" + simpledateformat + ".xls";
		File file = new File(pathname);
		boolean bool = file.createNewFile();
		boolean fileexists = file.exists();
		boolean updated = false;
		if (fileexists) {
			System.out.println("File Already Exists");
			updated = true;
		} else {
			if (bool) {
				System.out.println("New File Created Successfully!!!");
			} else {
				System.out.println("New File Not Created!!!");
			}
		}
		WritetoExcel excel = new WritetoExcel();
		excel.writing_to_excel();
	}

	public void writing_to_excel() throws IOException, SQLException {
		Date date = new Date();
		String simpledateformat = new SimpleDateFormat("dd-MM-yyyy")
				.format(date);
		String pathname = "D:\\Expense_Sheet_" + simpledateformat + ".xls";
		FileOutputStream fileout = new FileOutputStream(pathname);
		String sheetname = "Expense";
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet(sheetname);
		HSSFRow row = sheet.createRow((short) 0);
		HSSFCell cellA = row.createCell((short) 0);
		//cellA.setCellValue("Date_Of_Purcha"e");
		//cellA.setCellValue("Date Of Purchase");
		cellA.setCellValue("Item Name");
		cellA.setCellValue("Category");
		cellA.setCellValue("Quantity");
		cellA.setCellValue("Unit");
		cellA.setCellValue("Amount Paid");
		cellA.setCellValue("Paid By");
		cellA.setCellValue("Paid On");
		cellA.setCellValue("Exclude");
		cellA.setCellValue("Comments");
		
		Connection connection=null;
		connection=DBConnector.getDBConnection();
		if(connection!=null)
		{			
			String sql="select * from expense_old";
			Statement statement=connection.createStatement();
			ResultSet rs=statement.executeQuery(sql);
			ArrayList list=new ArrayList();
			ResultSetMetaData metadata = rs.getMetaData();
			int numberOfColumns = metadata.getColumnCount();
			
			while(rs.next())
			{
				int i=1;
				while(i <= numberOfColumns )
				{
					System.out.println(rs.getString(1));
					System.out.println(rs.getString(2));
					System.out.println(rs.getString(3));
					System.out.println(rs.getString(4));
					System.out.println(rs.getDouble(5));
					System.out.println(rs.getDouble(6));
					System.out.println(rs.getString(7));
					System.out.println(rs.getString(8));
					System.out.println(rs.getString(9));
					System.out.println(rs.getString(10));
					i=i+numberOfColumns;
					list.add(rs);
				}
				
			}
		}
		workbook.write(fileout);
		fileout.flush();
		fileout.close();

	}
}
