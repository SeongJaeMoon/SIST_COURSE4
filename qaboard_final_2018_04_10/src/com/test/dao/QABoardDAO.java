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
	
	//��ü ��� �޼ҵ�
	//-> ����ε� ���� 0�� ��츸 �о�´�
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
	
	//��ü ��� �޼ҵ� + ����¡
	//-> ����ε� ���� 0�� ��츸 �о�´�
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
	
	//�Է� �޼ҵ�
	//->�۹�ȣ ���� Ȯ��
	//->��б�(pw ������ ���� null�� �ƴ� ���) �Է��� ��� �н����� ���� ����
	//->Ʈ����� ó��
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
			
			// Ʈ����� ����
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
			
			// Ŀ�� �׼�
			conn.commit();
			
		} catch (SQLException se) {
			// �ѹ� �׼�
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
	
	
	//��б� Ȯ���� ���� �˻� �޼ҵ�
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
	
	
	//�Խù� �� ��ȯ �޼ҵ�
	public int totalCount() {
		int result = 0;
		
		//����) �Ϲݻ���� ���� �ۼ��ؾ� �Ѵ�.
		String sql = "SELECT COUNT(*) AS totalCount FROM QABoardTable WHERE blind = 0";

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
	

}
