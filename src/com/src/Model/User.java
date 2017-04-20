package com.src.Model;

import java.util.Date;

public class User {
	private int user_id;
	private String username;
	private int gender_id;
	private String email;
	private Date start_date;
	private Date leaving_date;
	private int name_id;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getUser_id() {
		return user_id;
	}

	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}

	public int getGender_id() {
		return gender_id;
	}

	public void setGender_id(int gender_id) {
		this.gender_id = gender_id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getStart_date() {
		return start_date;
	}

	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}

	public Date getLeaving_date() {
		return leaving_date;
	}

	public void setLeaving_date(Date leaving_date) {
		this.leaving_date = leaving_date;
	}

	public int getName_id() {
		return name_id;
	}

	public void setName_id(int name_id) {
		this.name_id = name_id;
	}
}