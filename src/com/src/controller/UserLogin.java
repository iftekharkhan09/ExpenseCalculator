package com.src.controller;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.mysql.jdbc.Connection;
import com.src.Model.Staff;

public class UserLogin {
	Staff staff;

	public Staff getStaff() {
		return staff;
	}

	public void setStaff(Staff staff) {
		this.staff = staff;
	}

	public boolean validate_user(Staff staff) throws SQLException {
		Connection conn = DBConnector.getDBConnection();
		String validation_query = "select * from staff where user_name = ? and password=?";
		PreparedStatement validation_statement = conn
				.prepareStatement(validation_query);
		validation_statement.setString(1, staff.getUsername());
		validation_statement.setString(2, staff.getPassword());
		ResultSet resultset = validation_statement.executeQuery();
		String user_name_validation = "select * from staff where user_name=?";
		PreparedStatement username_validation_statement = conn
				.prepareStatement(user_name_validation);
		username_validation_statement.setString(1, staff.getUsername());
		ResultSet result_set_username_validation = username_validation_statement
				.executeQuery();
		if (resultset.next()) {
			validation_statement.close();
			resultset.close();
			conn.close();
			return true;
		} else if (!resultset.next() && result_set_username_validation.next()) {
			set_no_of_unsuccessful_attempts(staff.getUsername());
		} else {
			return false;
		}
		return false;
	}

	public boolean isblocked(Staff staff) throws SQLException {
		Connection conn = DBConnector.getDBConnection();
		String block_validation_query = "select blocked from staff where user_name = ? and password= ?";
		PreparedStatement block_validation_statement = conn
				.prepareStatement(block_validation_query);
		block_validation_statement.setString(1, staff.getUsername());
		block_validation_statement.setString(2, staff.getPassword());
		ResultSet resultset = block_validation_statement.executeQuery();
		String block = null;
		while (resultset.next()) {
			block = resultset.getString(1);
		}
		if (block != null) {
			if (block.equals("Y")) {
				block_validation_statement.close();
				resultset.close();
				conn.close();
				return true;
			}
		}
		block_validation_statement.close();
		resultset.close();
		conn.close();
		return false;
	}

	public boolean is_admin(Staff staff) throws SQLException {
		Connection conn11 = DBConnector.getDBConnection();
		try {
			String query1 = "select is_admin from staff where user_name=? and password=?";
			PreparedStatement admin_statement = conn11.prepareStatement(query1);
			admin_statement.setString(1, staff.getUsername());
			admin_statement.setString(2, staff.getPassword());
			ResultSet resultset11 = admin_statement.executeQuery();
			String admin = null;
				while (resultset11.next()) {
					admin = resultset11.getString(1);
				}
				if (admin != null) {
					if (admin.equals("Y")) {
						admin_statement.close();
						resultset11.close();
						conn11.close();
						return true;
					}
				}
			}
		 finally {
			conn11.close();
		}
		return false;
	}

	public boolean set_no_of_unsuccessful_attempts(String username)
			throws SQLException {
		Connection conn = DBConnector.getDBConnection();
		try {
			String query = "select unsuccessful_login_attempts from staff where user_name=?";
			PreparedStatement statement = conn.prepareStatement(query);
			statement.setString(1, username);
			ResultSet result = statement.executeQuery();
			int unsuccessful_attempts = 0;
			while (result.next()) {
				unsuccessful_attempts = result.getInt(1);
			}
			statement.close();
			result.close();
			String query1 = "update staff set unsuccessful_login_attempts=? where user_name=?";
			PreparedStatement update_staff_statement = conn
					.prepareStatement(query1);
			update_staff_statement.setInt(1, unsuccessful_attempts + 1);
			update_staff_statement.setString(2, username);
			int no_of_unsuccessful_attempts = update_staff_statement
					.executeUpdate();
			if (no_of_unsuccessful_attempts > 0) {
				String no_of_unsuccessful_login_attempts = "select unsuccessful_login_attempts from staff where user_name=?";
				PreparedStatement login_atempts = conn
						.prepareStatement(no_of_unsuccessful_login_attempts);
				login_atempts.setString(1, username);
				ResultSet unsuccessfull_login_attempts_statement = login_atempts
						.executeQuery();
				int attempts = 0;
				while (unsuccessfull_login_attempts_statement.next()) {
					attempts = unsuccessfull_login_attempts_statement.getInt(1);
				}
				if (attempts >= 3) {
					block_user(username);
					return false;
				}
				update_staff_statement.close();
				login_atempts.close();
				unsuccessfull_login_attempts_statement.close();
				conn.close();
				return false;
			}
			update_staff_statement.close();
			conn.close();
		} finally {
			conn.close();
		}
		return false;
	}

	public void block_user(String username) throws SQLException {
		Connection conn = DBConnector.getDBConnection();
		try {
			String block_user = "update staff set blocked=? where user_name=?";
			PreparedStatement statement = conn.prepareStatement(block_user);
			statement.setString(1, "Y");
			statement.setString(2, username);
			int is_blocked = statement.executeUpdate();
			if (is_blocked > 0) {
			}
		} finally {
			conn.close();
		}
	}

	public boolean validate(Staff staff) throws SQLException {
		if (validate_user(staff) && !isblocked(staff))
			return true;
		return false;
	}
}