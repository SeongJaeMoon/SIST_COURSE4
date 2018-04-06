package com.test;

import java.sql.*;
import java.util.*;
import java.time.*;

public class MemberDAO {

	// 전체 명단 출력용 메소드
	public List<Member> list() {
		List<Member> result = new ArrayList<Member>();

		/*
		 * CREATE VIEW membersView AS SELECT mid_, name_, phone, email, regDate,
		 * deptName FROM members INNER JOIN dept USING(deptID) ORDER BY mid_;
		 */

		String sql = "SELECT mid_, name_, phone, email, regDate, deptName FROM membersView ORDER BY mid_";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				String mid_ = rs.getString("mid_");
				String name_ = rs.getString("name_");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				String deptName = rs.getString("deptName");

				Member m = new Member();

				m.setMid_(mid_);
				m.setName_(name_);
				m.setPhone(phone);
				m.setEmail(email);
				m.setRegDate(regDate);
				m.setDeptName(deptName);

				result.add(m);

			}
			rs.close();

		} catch (SQLException se) {
			System.out.print(se.getMessage());
		} catch (Exception e) {
			System.out.print(e.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException se) {
			}
			try {
				MySQLConnection.close();
			} catch (SQLException se) {
				System.out.print(se.getMessage());
			}
		}

		return result;
	}

	// 전체 출력 및 검색 결과 출력용 메소드
	public List<Member> list(String key, String value) {
		List<Member> result = new ArrayList<Member>();

		/*
		 * CREATE VIEW membersView AS SELECT mid_, name_, phone, email, regDate,
		 * deptName FROM members INNER JOIN dept USING(deptID) ORDER BY mid_;
		 */

		String sql = "SELECT mid_, name_, phone, email, regDate, deptName FROM membersView";

		// key, value를 이용한 검색 조건 지정
		// ->key가 "ALL"인 경우는 전체 출력.
		switch (key) {
		case "ALL":
			sql += "";
			break;
		case "mid_":
			sql += " WHERE mid_ = ?";
			break;
		case "name_":
			sql += " WHERE INSTR(name_, ?)";
			break;
		case "phone":
			sql += " WHERE INSTR(phone, ?)";
			break;
		case "email":
			sql += " WHERE INSTR(email, ?)";
			break;
		case "regDate":
			sql += " WHERE INSTR(regDate, ?)";
			break;
		case "deptName":
			sql += " WHERE INSTR(deptName, ?)";
			break;
		}
		sql += " ORDER BY mid_";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);

			if (!key.equals("ALL")) {
				pstmt.setString(1, value);
			}

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				String mid_ = rs.getString("mid_");
				String name_ = rs.getString("name_");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				String deptName = rs.getString("deptName");

				Member m = new Member();

				m.setMid_(mid_);
				m.setName_(name_);
				m.setPhone(phone);
				m.setEmail(email);
				m.setRegDate(regDate);
				m.setDeptName(deptName);

				result.add(m);

			}
			rs.close();

		} catch (SQLException se) {
			System.out.print(se.getMessage());
		} catch (Exception e) {
			System.out.print(e.getMessage());
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException se) {
			}
			try {
				MySQLConnection.close();
			} catch (SQLException se) {
				System.out.print(se.getMessage());
			}
		}

		return result;
	}

	// 회원정보 입력용 메소드
	public int memberAdd(Member m) {
		int result = 0;

		String sql = "INSERT INTO members (mid_, name_, phone, email, regDate, deptId) VALUES ((SELECT * FROM (SELECT CONCAT('M', LPAD(IFNULL(SUBSTRING(MAX(mid_), 2), 0) + 1, 2, 0)) AS newMid FROM members) m) , ?, ?, ?, ?, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, m.getName_());
			pstmt.setString(2, m.getPhone());
			pstmt.setString(3, m.getEmail());
			pstmt.setString(4, m.getRegDate().toString());
			pstmt.setString(5, m.getDeptId());

			result = pstmt.executeUpdate();

		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException se) {
			}
			try {
				MySQLConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}

		return result;
	}

	// 부서 정보 읽기용 메소드
	public List<Member> deptList() {
		List<Member> result = new ArrayList<Member>();

		String sql = "SELECT deptId, deptName FROM dept ORDER BY deptId";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);
			// 외부데이터 바인딩 과정 추가하는 위치
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				String deptId = rs.getString("deptId");
				String deptName = rs.getString("deptName");

				Member m = new Member();
				m.setDeptId(deptId);
				m.setDeptName(deptName);
				result.add(m);

			}
			rs.close();

		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException se) {
			}
			try {
				MySQLConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return result;

	}

	// 전체 인원수 확인용 메소드
	public int totalCount() {
		int result = 0;

		String sql = "SELECT COUNT(*) AS totalCount FROM membersView";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);
			// 외부데이터 바인딩 과정 추가하는 위치
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				result = rs.getInt("totalCount");
			}
			rs.close();

		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException se) {
			}
			try {
				MySQLConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}

		return result;
	}

	// 회원 정보 삭제 메소드
	public int memberRemove(String mid_) {
		int result = 0;

		String sql = "DELETE FROM members WHERE mid_=?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);
			// 외부데이터 바인딩 과정 추가하는 위치
			pstmt.setString(1, mid_);
			result = pstmt.executeUpdate();

		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException se) {
			}
			try {
				MySQLConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}

		return result;
	}

	// 회원 정보 수정 메소드
	public int memberModify(Member m) {
		int result = 0;

		String sql = "UPDATE members SET name_ = ?, phone = ?, email = ?, regDate = ?, deptId = ? WHERE mid_ = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, m.getName_());
			pstmt.setString(2, m.getPhone());
			pstmt.setString(3, m.getEmail());
			pstmt.setString(4, m.getRegDate().toString());
			pstmt.setString(5, m.getDeptId());
			pstmt.setString(6, m.getMid_());

			result = pstmt.executeUpdate();

		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (SQLException se) {
			}
			try {
				MySQLConnection.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		return result;
	}

}
