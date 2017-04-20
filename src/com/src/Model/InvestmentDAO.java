package com.src.Model;

public class InvestmentDAO {
	
	private String date;
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getParticulars() {
		return particulars;
	}
	public void setParticulars(String particulars) {
		this.particulars = particulars;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getPaidby() {
		return paidby;
	}
	public void setPaidby(String paidby) {
		this.paidby = paidby;
	}
	private String particulars;
	private double price;
	private String paidby;

}
 