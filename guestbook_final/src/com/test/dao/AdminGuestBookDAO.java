package com.test.dao;

import com.test.domain.*;
import java.sql.*;
import java.util.*;
import java.time.*;

public class AdminGuestBookDAO {

	// 방명록 출력(검색) 메소드
	public List<AdminGuestBook> guestBookList(String key, String value) {
		List<AdminGuestBook> result = new ArrayList<AdminGuestBook>();

		// 주의) 관리자 모드로 작성해야 한다.
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

	// 방명록 게시물 수 반환 메소드
	public int totalCount() {
		int result = 0;

		// 주의) 관리자 모드로 작성해야 한다.
		String sql = "SELECT COUNT(*) AS totalcount FROM guestbook";

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

	// 방명록 블라인드 메소드
	public int blind(AdminGuestBook gb) {
		int result = 0;
		
		String sql = "UPDATE guestbook SET blind=? WHERE gid=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, gb.getBlind());
			pstmt.setString(2, gb.getGid());

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

	// 사진 출력(검색) 메소드
	public List<AdminGuestBook> picList(String key, String value) {
		List<AdminGuestBook> result = new ArrayList<AdminGuestBook>();
		
		String sql = "SELECT pid, picName, picContent FROM pictureList";
		
		//검색 기준에 따른 WHERE 구문 추가
		if (key.equals("pid")) {
			sql += " WHERE pid =? ";
		}
		sql += " ORDER BY pid";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);
			
			//검색 기준에 따른 데이터 바인딩
			if (key.equals("pid")) {
				pstmt.setString(1, value);
			}
			
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				String pid = rs.getString("pid");
				String picName = rs.getString("picName");
				String picContent = rs.getString("picContent");

				AdminGuestBook gb = new AdminGuestBook();

				gb.setPid(pid);
				gb.setPicName(picName);
				gb.setPicContent(picContent);

				result.add(gb);

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
	
	
	// 사진 정보(파일 이름, 사진 설명) 입력 메소드
	public int pictureAdd(AdminGuestBook gb) {
		int result = 0;

		String sql = "INSERT INTO pictureList (pid, picName, picContent) VALUES ((SELECT * FROM (SELECT CONCAT('P', LPAD(IFNULL(SUBSTRING(MAX(pid), 2), 0) + 1, 3, 0)) AS newPid FROM pictureList) p), ?, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = MySQLConnection.connect();
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, gb.getPicName());
			pstmt.setString(2, gb.getPicContent());

			result = pstmt.executeUpdate();

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
	
	
	//사진 정보 삭제 메소드
	public int pictureRemove(String pid) {
		int result = 0;
		
		String sql = "DELETE FROM picturelist WHERE pid = ?";

		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = MySQLConnection.connect();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pid);
			result = pstmt.executeUpdate();

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
