package com.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.test.domain.QABoard;

public class QABoardDAO {
	
	//전체 출력 메소드
	//-> 블라인드 값이 0인 경우만 읽어온다
	public List<QABoard> list() {
		List<QABoard> result = new ArrayList<QABoard>();
		
		String sql = "SELECT qid, title, content, writeday, clientip, blind, privacy, (SELECT replyContent FROM qaboardreplytable WHERE qid=qa.qid) AS replyContent FROM QABoardTable qa WHERE blind=0 ORDER BY qid DESC";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();
			
			
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				String qid = rs.getString("qid");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String clientIP = rs.getString("clientip");
				LocalDate writeday = rs.getDate("writeday").toLocalDate();
				int blind = rs.getInt("blind");
				int privacy = rs.getInt("privacy");
				String replyContent = rs.getString("replyContent");

				QABoard qa = new QABoard();
				qa.setQid(qid);
				qa.setTitle(title);
				qa.setContent(content);
				qa.setClientIP(clientIP);
				qa.setBlind(blind);
				qa.setPrivacy(privacy);
				qa.setWriteday(writeday);
				qa.setReplyContent(replyContent);

				result.add(qa);

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
	
	//전체 출력 메소드 + 페이징
	//-> 블라인드 값이 0인 경우만 읽어온다
	public List<QABoard> list(int offset, int count) {
		List<QABoard> result = new ArrayList<QABoard>();
		
		String sql = "SELECT qid, title, content, writeday, clientip, blind, privacy, (SELECT replyContent FROM qaboardreplytable WHERE qid=qa.qid) AS replyContent FROM QABoardTable qa WHERE blind=0 ORDER BY qid DESC";
		
		sql += String.format(" LIMIT %s, %s", offset, count);
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();
			
			
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				String qid = rs.getString("qid");
				String title = rs.getString("title");
				String content = rs.getString("content");
				String clientIP = rs.getString("clientip");
				LocalDate writeday = rs.getDate("writeday").toLocalDate();
				int blind = rs.getInt("blind");
				int privacy = rs.getInt("privacy");
				String replyContent = rs.getString("replyContent");

				QABoard qa = new QABoard();
				qa.setQid(qid);
				qa.setTitle(title);
				qa.setContent(content);
				qa.setClientIP(clientIP);
				qa.setBlind(blind);
				qa.setPrivacy(privacy);
				qa.setWriteday(writeday);
				qa.setReplyContent(replyContent);

				result.add(qa);

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
	
	//입력 메소드
	//->글번호 별도 확보
	//->비밀글(pw 변수의 값이 null이 아닌 경우) 입력인 경우 패스워드 별도 저장
	//->트랜잭션 처리
	public int add(QABoard qa) {
		int result = 0;
		
		String sql1 = "SELECT CONCAT('Q', LPAD(IFNULL(SUBSTRING(MAX(qid), 2), 0) + 1, 3, 0)) AS qid FROM QABoardTable";
		String sql2 = "INSERT INTO QABoardTable (qid, title, content, writeday, clientip, blind, privacy) VALUES (?, ?, ?, NOW(), ?, 0, ?)";
		String sql3 = "INSERT INTO QABoardPasswordTable (qid, pw) VALUES (?, ?)";
		String qid = null;
		
		Connection conn = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		try {
			conn = MySQLConnection.connect();
			
			// 트랜잭션 선언
			conn.setAutoCommit(false);
			
			pstmt1 = conn.prepareStatement(sql1);
			ResultSet rs = pstmt1.executeQuery();
			while (rs.next()) {
				qid = rs.getString("qid");
			}
			rs.close();
			
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setString(1, qid);
			pstmt2.setString(2, qa.getTitle());
			pstmt2.setString(3, qa.getContent());
			pstmt2.setString(4, qa.getClientIP());
			if (qa.getPw() == null) {
				pstmt2.setInt(5, 0);
			} else {
				pstmt2.setInt(5, 1);
			}
			result = pstmt2.executeUpdate();
			
			if (qa.getPw() != null) {
				pstmt3 = conn.prepareStatement(sql3);
				pstmt3.setString(1, qid);
				pstmt3.setString(2, qa.getPw());
				result = pstmt3.executeUpdate();
			}
			
			// 커밋 액션
			conn.commit();
			
		} catch (SQLException se) {
			// 롤백 액션
			try {
				conn.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt1 != null)
					pstmt1.close();
				if (pstmt2 != null)
					pstmt2.close();
				if (pstmt3 != null)
					pstmt3.close();
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
	
	
	//비밀글 확인을 위한 검색 메소드
	//-> qid, pw
	public QABoard ajaxContent(QABoard qa) {
		QABoard result = null;
		
		String sql = "SELECT qid, pw, content FROM QABoardTable INNER JOIN QABoardPasswordTable USING(qid) WHERE qid=? AND pw=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, qa.getQid());
			pstmt.setString(2, qa.getPw());
			
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {

				String content = rs.getString("content");

				result = new QABoard();
				result.setContent(content);

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
	
	
	//게시물 수 반환 메소드
	public int totalCount() {
		int result = 0;
		
		//주의) 일반사용자 모드로 작성해야 한다.
		String sql = "SELECT COUNT(*) AS totalCount FROM QABoardTable WHERE blind = 0";

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
	

}
