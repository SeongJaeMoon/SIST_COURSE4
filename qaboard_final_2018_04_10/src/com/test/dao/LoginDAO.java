package com.test.dao;

import com.test.domain.*;
import java.sql.*;

public class LoginDAO {
	
	//로그인 메소드
	public Login login(Login l) {
		Login result = null;
		
		//데이터베이스 질의 결과 올바른 관리자 또는 일반사용자인 경우 Login 객체 생성
		String sql = "SELECT id_, grade FROM login WHERE id_=? AND pw_=? AND grade=?";

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
				String id_ = rs.getString("id_");
				int grade = rs.getInt("grade");

				result = new Login();
				result.setId_(id_);
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
