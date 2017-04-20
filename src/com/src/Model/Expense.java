package com.src.Model;

import java.sql.Date;

public class Expense {
	int item_id;
	int reason_id;
	public int getReason_id() {
		return reason_id;
	}
	public void setReason_id(int reason_id) {
		this.reason_id = reason_id;
	}
	String date_of_purchase;
	Date Updated_time;
	String exclude;
	double quantity_purchased;
	public double getQuantity_purchased() {
		return quantity_purchased;
	}
	public void setQuantity_purchased(double quantity_purchased) {
		this.quantity_purchased = quantity_purchased;
	}
	int Amount_paid_by;
	double total_price;
	int Updated_by;
	int expense_id;
	String comments;
	public int getItem_id() {
		return item_id;
	}
	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}
	public String getDate_of_purchase() {
		return date_of_purchase;
	}
	public void setDate_of_purchase(String date_of_purchase) {
		this.date_of_purchase = date_of_purchase;
	}
	public Date getUpdated_time() {
		return Updated_time;
	}
	public void setUpdated_time(Date updated_time) {
		Updated_time = updated_time;
	}
	public String getExclude() {
		return exclude;
	}
	public void setExclude(String exclude) {
		this.exclude = exclude;
	}
	
	public int getAmount_paid_by() {
		return Amount_paid_by;
	}
	public void setAmount_paid_by(int amount_paid_by) {
		Amount_paid_by = amount_paid_by;
	}
	public double getTotal_price() {
		return total_price;
	}
	public void setTotal_price(double total_price) {
		this.total_price = total_price;
	}
	public int getUpdated_by() {
		return Updated_by;
	}
	public void setUpdated_by(int updated_by) {
		Updated_by = updated_by;
	}
	public int getExpense_id() {
		return expense_id;
	}
	public void setExpense_id(int expense_id) {
		this.expense_id = expense_id;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}

	}