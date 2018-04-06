package com.test.dao;

import java.util.*;
import com.test.domain.*;
import java.sql.*;
import java.time.LocalDate;

public class QABoardDAO {

	
	//전체 QABoard 출력(+페이징 offset, count)
	// ->블라인드 값이 0인 경우만 읽어온다.
	public List<QABoard> list(){
		
		String sql = "SELECT qid, title, writeday, content_, clientip, blind, privacy FROM QABoardTable WHERE blind = 0 ORDER BY qid DESC";

		Connection conn = null;
		PreparedStatement pstmt = null;

		List<QABoard> ret = new ArrayList<QABoard>();
		
		try {
			conn = MySQLConnection.connect();
			pstmt = conn.prepareStatement(sql);

		
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String qid = rs.getString("qid");
				String title = rs.getString("title");
				String content_ = rs.getString("content_");
				LocalDate writeday = rs.getDate("writeday").toLocalDate();
				String clientip = rs.getString("clientip");
				int privacy = rs.getInt("privacy");
				
				QABoard qa = new QABoard();
				qa.setQid(qid);
				qa.setTitle(title);
				qa.setWriteday(writeday);
				qa.setClientip(clientip);
				qa.setPrivacy(privacy);
				qa.setContent_(content_);
				
				ret.add(qa);
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
		return ret;
	}
	
	//글 입력 메소드 (비밀글 입력 가능 pw 변수의 값이 null이 아닌 경우) 
	//-> 글 번호 별도 확보 S
	//-> 패스워드 별도 저장 I
	// -> 트랜잭션 처리
	
	
	public int add(QABoard qa) {
		int ret = 0;
	
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql1 = "INSERT INTO QABoardTable (qid, title, content_, clientip, privacy) VALUES ((SELECT * FROM (SELECT CONCAT('q', LPAD(IFNULL(SUBSTRING(MAX(qid), 2), 0) + 1, 3, 0)) AS newqid FROM qaboardtable) q), ?, ?, ?, ?)";
		String sql2 = "SELECT qid FROM QABoardTable WHERE ORDER BY qid DESC LIMIT 1";
		String sql3 = "INSERT INTO QABoardPasswordTable (qid, pw) VALUES (?, ?)";		
		
		try {
			conn = MySQLConnection.connect();
			conn.setAutoCommit(false);
			
			pstmt = conn.prepareStatement(sql1);
			
			pstmt.setString(1, qa.getTitle());
			pstmt.setString(2, qa.getContent_());
			pstmt.setString(3, qa.getClientip());
			
			
			if(qa.getPw() == null) {
				pstmt.setInt(4, 0);
				
				ret = pstmt.executeUpdate();
				
			}else {
				pstmt.setInt(4, 1);
				
				pstmt.executeUpdate();
				
				pstmt = conn.prepareStatement(sql2);
				
				ResultSet rs = pstmt.executeQuery();
				
				String qid = "";
				
				while(rs.next()) {
					qid = rs.getString("qid");
				}
				rs.close();

				
				pstmt = conn.prepareStatement(sql3);
				
				pstmt.setString(1, qid);
				pstmt.setString(2, qa.getPw());
				
				ret = pstmt.executeUpdate();
				
			}
			conn.commit();

		} catch (SQLException se) {
			System.out.println(se.getMessage());
			try {
				conn.rollback();
			}catch (SQLException e){
				e.printStackTrace();
			}
			
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
		
		
		return ret;
	}
	
}

