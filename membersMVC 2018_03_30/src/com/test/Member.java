package com.test;

import java.time.*;

//자료형 클래스
public class Member {
	
	//필드 구성
	//->입력, 출력에 관여된 모든 항목
	//->동일 자료, 동일 식별자
	private String mid_, name_, phone, email, deptId, deptName;
	private LocalDate regDate;
	
	public String getMid_() {
		return mid_;
	}
	public void setMid_(String mid_) {
		this.mid_ = mid_;
	}
	public String getName_() {
		return name_;
	}
	public void setName_(String name_) {
		this.name_ = name_;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public LocalDate getRegDate() {
		return regDate;
	}
	public void setRegDate(LocalDate regDate) {
		this.regDate = regDate;
	}
	

}
