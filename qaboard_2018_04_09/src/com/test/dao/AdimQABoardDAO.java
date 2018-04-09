package com.test.dao;

import java.util.*;
import com.test.domain.*;
import java.sql.*;
import java.time.LocalDate;

public class AdimQABoardDAO {
	
public List<QABoard> list(){
		
		String sql = "SELECT qid, title, writeday, content_, clientip, blind, privacy, (SELECT replyContent FROM qaboardreplytable WHERE qid = qa.qid) AS replyContent FROM QABoardTable qa ORDER BY qid DESC";

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
				String replyContent = rs.getString("replyContent");
				
				QABoard qa = new QABoard();
				
				qa.setQid(qid);
				qa.setTitle(title);
				qa.setWriteday(writeday);
				qa.setClientip(clientip);
				qa.setPrivacy(privacy);
				qa.setContent_(content_);
				qa.setReplyContent(replyContent);
				
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
	
	
	//관리자의 reply 등록 메소드
		public int insert(QABoard qa) {
			int ret = 0;
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			String sql ="INSERT INTO QABoardReplyTable (qid, replyContent) VALUES (?, ?)";	
			
			try {
				conn = MySQLConnection.connect();

				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, qa.getQid());
				pstmt.setString(2, qa.getReplyContent());
				
				ret = pstmt.executeUpdate();			

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
		//관리자의 reply 삭제 메소드
		public int remove(String qid) {
				int ret = 0;
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			String sql ="DELETE FROM qaboardreplytable WHERE qid = ?";	
			
			try {
				conn = MySQLConnection.connect();

				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, qid);
				
				ret = pstmt.executeUpdate();			

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
		public int totalCount() {
			int result = 0;

			String sql = "SELECT COUNT(*) AS totalcount FROM qaboardtable";

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

		public int blind(QABoard qa) {
			int result = 0;
			
			String sql = "UPDATE qaboardtable SET blind= ? WHERE gid= ?";
			
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
