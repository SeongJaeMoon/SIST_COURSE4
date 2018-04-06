package com.test.dao;

import java.sql.*;

//데이터베이스 연결 정보 관리 클래스
public class MySQLConnection {
	
	// JDBC driver name and database URL
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_URL = "jdbc:mysql://211.63.89.95:3306/moon?useSSL=false";

	// Database credentials
	static final String USER = "moon";
	static final String PASS = "1234";	
	
	private static Connection conn;
	
	//데이테베이스 커넥션 객체 생성 메소드
	public static Connection connect() throws ClassNotFoundException, SQLException {
		
		// STEP 2: Register JDBC driver
		Class.forName(JDBC_DRIVER);
		// STEP 3: Open a connection
		conn = DriverManager.getConnection(DB_URL, USER, PASS);
		
		return conn;
	}
	
	//데이테베이스 커넥션 객체 소멸 메소드
	public static void close() throws SQLException {
		if (conn != null) {
			conn.close();
		}
	}
	
}
