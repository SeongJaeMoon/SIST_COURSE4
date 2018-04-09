package com.test.dao;

import com.test.domain.*;
import java.sql.*;

public class LoginDAO {
	
	public Login login(Login l) {
		Login result = null;
		//일반 사용자도 로그인 할 수 있어야 한다.
		String sql = "SELECT id_, grade FROM login WHERE id_ = ? AND pw_ = ? AND grade = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = MySQLConnection.connect();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, l.getId_());
			pstmt.setString(2, l.getPw_());
			pstmt.setInt(3, l.getGrade());
			
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				
				int grade = rs.getInt("grade");

				result = new Login();
				result.setGrade(grade);

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
