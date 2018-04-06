package com.test;

import java.sql.*;

public class LoginDAO {
	
	//로그인 메소드
	public Login login(Login l) {
		Login result = null;
		
		//데이터베이스 질의 결과 올바른 관리자인 경우 Login 객체 생성
		/*
		CREATE OR REPLACE VIEW loginInfoView
		AS
		SELECT mid_, id, pw, name_, phone, email, regDate 
			FROM loginInfo l INNER JOIN members m USING(id);
		*/

		String sql = "SELECT id, name_, phone, email, regDate FROM loginInfoView WHERE id=? AND pw=?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = MySQLConnection.connect();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, l.getId());
			pstmt.setString(2, l.getPw());

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String id = rs.getString("id");
				String name_ = rs.getString("name_");
				String phone = rs.getString("phone");
				String email = rs.getString("email");

				result = new Login();
				result.setId(id);
				result.setName_(name_);
				result.setPhone(phone);
				result.setEmail(email);

			}
			rs.close();

		} catch (SQLException se) {
			System.out.println(se.getMessage());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException se) {
			}
			try {
				MySQLConnection.close();
			} catch (SQLException se) {
				System.out.println(se.getMessage());
			}
		}
		
		return result;
	}

}
