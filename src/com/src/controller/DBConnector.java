package com.src.controller;

import java.sql.DriverManager;
import com.mysql.jdbc.Connection;

public class DBConnector {

	public static Connection getDBConnection() {
		String url = "jdbc:mysql://localhost:3306/";
		String dbName = "ifte_test";
		String driver = "com.mysql.jdbc.Driver";
		String userName = "root";
		String password = "Sunny";
		Connection conn = null;
		try {
			Class.forName(driver).newInstance();
			conn = (Connection) DriverManager.getConnection(url + dbName,
					userName, password);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;

	}
}