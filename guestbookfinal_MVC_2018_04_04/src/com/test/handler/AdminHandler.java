package com.test.handler;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;
import com.test.dao.AdminGuestBookDAO;
import com.test.domain.AdminGuestBook;
import com.test.util.*;


import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.io.output.*;

public class AdminHandler {
	
	private AdminGuestBookDAO dao;
	
	public AdminHandler() {
		this.dao = new AdminGuestBookDAO();
	}
	
	
	public String booklist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//검색 진행 -> key, value
		String key = "ALL";
		String value = "";

		key = request.getParameter("key");
		value = request.getParameter("value");
		if (key == null) {
			key = "ALL";
			value = "";
		}
		
		List<AdminGuestBook> gbList = this.dao.guestBookList(key, value);
		
		int totalCount = this.dao.totalCount();
		int gbListCount = gbList.size();
		
		request.setAttribute("gbList", gbList);
		request.setAttribute("gbListCount", gbListCount);
		request.setAttribute("key", key);
		request.setAttribute("value", value);
		request.setAttribute("totalCount", totalCount);
		
		return "/WEB-INF/views/admin/adminbooklist.jsp";
	}
	
	//admin/blind
	public String blind(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		
		String blind = request.getParameter("blind");
		String gid = request.getParameter("gid");
		
		AdminGuestBook ab = new AdminGuestBook();
		
		ab.setBlind(Integer.parseInt(blind));
		ab.setGid(gid);
		
		int ret = this.dao.blindGuestBook(ab);
		
		return String.format("redirect:%s/admin/booklist?ret=%s", request.getContextPath(), ret);
	}
	
	//admin/picturelist
	public String picturelist(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		
		//사진 출력 액션 --------------
		List<AdminGuestBook> picList = this.dao.pickList();

		int picListLength = picList.size();
		
		request.setAttribute("picList", picList);
		request.setAttribute("picListLength", picListLength);
		
		return "/WEB-INF/views/admin/adminpicturelist.jsp";
	}
	
	//admin/pictureinsert
	public String pictureinsert(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		File file;
		int maxFileSize = 5 * 1024 * 1024;
		int maxMemSize = 5 * 1024 * 1024;
		int ret = 0;
	 	String filePath = request.getServletContext().getRealPath("resources//pictures");
	 	
	 	System.out.println(filePath);
	 	String newFileName = "";
		String contentType = request.getContentType();
		AdminGuestBook ag = new AdminGuestBook();
		
		if ((contentType.indexOf("multipart/form-data") >= 0)) {
			DiskFileItemFactory factory = new DiskFileItemFactory();
			
			factory.setSizeThreshold(maxMemSize);

			factory.setRepository(new File("c:\\temp"));

			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setHeaderEncoding("UTF-8");
			
			upload.setSizeMax(maxFileSize);
			
			try {

				List<FileItem> fileItems = upload.parseRequest(request);

				Iterator<FileItem> i = fileItems.iterator();
				
				while (i.hasNext()) {
					FileItem fi = (FileItem) i.next();
					
					if (fi.isFormField()) {
						String contents = fi.getString("UTF-8");
						ag.setPicContent(contents);
					}else{
					
						String fileName = fi.getName();
			
						//콘텐츠 타입 검사 및 사용자 예외 발생
						String mimetype = request.getServletContext().getMimeType(fileName);
						
						if((!mimetype.equals("image/jpeg")) && (!mimetype.equals("image/png"))){
							throw new FileException("file type error!!");
						}
						
						//현재 파일의 확장자;					
						String ext = fileName.substring(fileName.lastIndexOf("."));
						
						//동적생선된 파일이름 + 기존확장자;
						newFileName = Util.randFileName() + ext;
						
						// Write the file
						file = new File(filePath + "\\" + newFileName);
										
						fi.write(file);
						ag.setPicName(newFileName);
						ret = this.dao.picInsert(ag);
					}
				}
				
			} catch (Exception ex) {
				System.out.println(ex);
				
			}
		} else {
			
		}
		
		return String.format("redirect:%s/admin/picturelist?ret=%s", request.getContextPath(), ret);
	}
	
	//admin/picturedelete
	public String picturedelete(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		
		String pid = request.getParameter("pid");
		
		List<AdminGuestBook> list = dao.pickList("pid", pid);
		
		int ret = 0;

		String filePath = request.getServletContext().getRealPath("resources//pictures");
		System.out.println(filePath);
		try{
			if(list.size() != 0){
				File file = new File(filePath + "\\" + list.get(0).getPicName());
				file.delete();

				ret = dao.picDelete(list.get(0).getPid());	
			}
			
		}catch (Exception e){
			System.out.println(e);
		}
		
		return String.format("redirect:%s/admin/picturelist?ret=%s", request.getContextPath(), ret);
	}
	
}
