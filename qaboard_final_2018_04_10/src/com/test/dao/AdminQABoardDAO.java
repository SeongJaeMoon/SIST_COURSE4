package com.test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.test.domain.QABoard;

public class AdminQABoardDAO {

	//전체 출력 메소드 ( + 페이징)
	public List<QABoard> list() {
		List<QABoard> result = new ArrayList<QABoard>();
		
		String sql = "SELECT qid, title, content, writeday, clientip, blind, privacy, (SELECT replyContent FROM qaboardreplytable WHERE qid=qa.qid) AS replyContent FROM QABoardTable qa ORDER BY qid DESC";
		
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
	
	
	//게시물 수 반환 메소드
	public int totalCount() {
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS totalCount FROM QABoardTable";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);
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
	
	//답변글 추가
	public int replyAdd(QABoard qa) {
		int result = 0;
		
		String sql = "INSERT INTO QABoardReplyTable (qid,replycontent) VALUES (?, ?)";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qa.getQid());
			pstmt.setString(2, qa.getReplyContent());
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
	
	//답변글 삭제
	public int replyRemove(QABoard qa) {
		int result = 0;
		
		String sql = "DELETE FROM QABoardReplyTable WHERE qid=?";

		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, qa.getQid());
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
	
	//블라인드 처리 메소드
	public int blind(QABoard qa) {
		int result = 0;
		
		String sql = "UPDATE QABoardTable SET blind=? WHERE qid=?";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = MySQLConnection.connect();

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, qa.getBlind());
			pstmt.setString(2, qa.getQid());

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
