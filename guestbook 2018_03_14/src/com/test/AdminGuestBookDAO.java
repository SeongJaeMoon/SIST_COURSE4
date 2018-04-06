package com.test;

import java.sql.*;
import java.util.*;
import java.time.*;

public class AdminGuestBookDAO {

	// ���� ���(�˻�) �޼ҵ�
	public List<AdminGuestBook> guestBookList(String key, String value) {
		List<AdminGuestBook> result = new ArrayList<AdminGuestBook>();

		// ����) ������ ���� �ۼ��ؾ� �Ѵ�.
		String sql = "SELECT gid, name_, content, regDate, clientIP, blind FROM guestbook";

		switch (key) {

		case "name_":
			sql += " WHERE INSTR(name_, ?)";
			break;

		case "content":
			sql += " WHERE INSTR(content, ?)";
			break;

		case "regDate":
			sql += " WHERE INSTR(CAST(regDate AS CHAR), ?)";
			break;

		case "ALL":
			break;
		}

		sql += " ORDER BY gid DESC";

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

				String gid = rs.getString("gid");
				String name_ = rs.getString("name_");
				String content = rs.getString("content");
				LocalDate regDate = rs.getDate("regDate").toLocalDate();
				String clientIP = rs.getString("clientIP");
				int blind = rs.getInt("blind");

				AdminGuestBook gb = new AdminGuestBook();
				gb.setGid(gid);
				gb.setName_(name_);
				gb.setContent(content);
				gb.setRegDate(regDate);
				gb.setClientIP(clientIP);
				gb.setBlind(blind);

				result.add(gb);

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

	// ���� �Խù� �� ��ȯ �޼ҵ�
	public int totalCount() {
		int result = 0;

		// ����) ������ ���� �ۼ��ؾ� �Ѵ�.
		String sql = "SELECT COUNT(*) AS totalcount FROM guestbook";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();
			pstmt = conn.prepareStatement(sql);
			// �ܺε����� ���ε� ���� �߰��ϴ� ��ġ
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

	// ���� ����ε� �޼ҵ�

	// ���� ��� �޼ҵ�

	// ���� �Է� �޼ҵ�

}
