package com.src.Model;

public class Item {
	Integer item_id;
	String Description;
	Integer unit_price_id;
	int Category_id;
	int Measurement_id;
	public Integer getItem_id() {
		return item_id;
	}
	public void setItem_id(Integer item_id) {
		this.item_id = item_id;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public Integer getUnit_price_id() {
		return unit_price_id;
	}
	public void setUnit_price_id(Integer unit_price_id) {
		this.unit_price_id = unit_price_id;
	}
	public int getCategory_id() {
		return Category_id;
	}
	public void setCategory_id(int category_id) {
		Category_id = category_id;
	}
	public int getMeasurement_id() {
		return Measurement_id;
	}
	public void setMeasurement_id(int measurement_id) {
		Measurement_id = measurement_id;
	}
}
