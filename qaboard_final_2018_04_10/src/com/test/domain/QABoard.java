package com.test.domain;

import java.time.LocalDate;

public class QABoard {
	
	//qid, title, content, writeday, clientIP, blind, privacy, replyContent, pw
	private String qid, title, content, clientIP, replyContent, pw;
	private int blind, privacy;
	private LocalDate writeday;
	
	public String getQid() {
		return qid;
	}
	public void setQid(String qid) {
		this.qid = qid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getClientIP() {
		return clientIP;
	}
	public void setClientIP(String clientIP) {
		this.clientIP = clientIP;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public int getBlind() {
		return blind;
	}
	public void setBlind(int blind) {
		this.blind = blind;
	}
	public int getPrivacy() {
		return privacy;
	}
	public void setPrivacy(int privacy) {
		this.privacy = privacy;
	}
	public LocalDate getWriteday() {
		return writeday;
	}
	public void setWriteday(LocalDate writeday) {
		this.writeday = writeday;
	}

	
	
}
