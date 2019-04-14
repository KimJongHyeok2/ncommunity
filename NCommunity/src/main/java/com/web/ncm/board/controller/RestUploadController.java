package com.web.ncm.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.web.ncm.board.domain.ImageUploadDTO;

@RestController
@RequestMapping("/upload")
public class RestUploadController {

	@PostMapping("/img")
	public ImageUploadDTO img(HttpServletRequest request) {
		
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		
		int maxPostSize = 1024 * 1024 * 5;
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload");

		File dir = new File(saveDirectory);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		String systemFileName = "";
		
		ImageUploadDTO dto = new ImageUploadDTO();
		
		try {
			MultipartRequest multi = new MultipartRequest(request, saveDirectory, maxPostSize, "UTF-8", policy);
			
			Enumeration<String> enums =  multi.getFileNames();
			while(enums.hasMoreElements()) {
				String name = enums.nextElement().toString();
				systemFileName = multi.getFilesystemName(name);
				
				dto.setUploaded(true);
				dto.setUrl(request.getScheme() + "://" + request.getServerName() + request.getContextPath() + "/resources/upload/" + systemFileName);
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return dto;
	}
}
