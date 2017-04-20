package com.src.controller;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFRow;

import com.src.Model.InvestmentDAO;
public class ReadExcel {
	@SuppressWarnings("deprecation")
	public static void main(String[] args) {
		try {
			InputStream input = new BufferedInputStream(new FileInputStream(
					"D:\\sunny.xls"));
			InvestmentDAO dao=new InvestmentDAO();
			
			
			POIFSFileSystem fs = new POIFSFileSystem(input);
			HSSFWorkbook wb = new HSSFWorkbook(fs);
			HSSFSheet sheet = wb.getSheetAt(0);
			Iterator rows = sheet.rowIterator();
			while (rows.hasNext()) {
				HSSFRow row = (HSSFRow) rows.next();
				int rownum=row.getRowNum();
				if(rownum==0)
					continue;
				Iterator cells = row.cellIterator();
				while (cells.hasNext()) {
					HSSFCell cell = (HSSFCell) cells.next();
					
					if(cell.getCellNum()==0)
					{
					if (HSSFDateUtil.isCellDateFormatted(row.getCell(0))) {
						
						Date date=row.getCell(0).getDateCellValue();
					    String DATE_FORMAT_NOW = "yyyy-MM-dd";
					    //Date date = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT_NOW);
					String stringDate = sdf.format(date );
					dao.setDate(stringDate);
					   
					    }
					}
					else
					{
					 if (HSSFCell.CELL_TYPE_NUMERIC == cell.getCellType())
						//System.out.print(cell.getNumericCellValue() + " ");
						 dao.setPrice(cell.getNumericCellValue());
					else if (HSSFCell.CELL_TYPE_STRING == cell.getCellType())
						System.out.print(cell.getStringCellValue() + " ");
						
					else if (HSSFCell.CELL_TYPE_BOOLEAN == cell.getCellType())
						System.out.print(cell.getBooleanCellValue() + " ");
					else if (HSSFCell.CELL_TYPE_BLANK == cell.getCellType())
						System.out.print("BLANK ");
					else
						System.out.print("Unknown cell type");
					
					
					}
				}
				
			}
		} catch (IOException ex) {
			ex.printStackTrace();
		}
	}
}