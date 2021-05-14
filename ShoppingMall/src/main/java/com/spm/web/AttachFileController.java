package com.spm.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spm.utils.AttachFileDTO;


import net.coobird.thumbnailator.Thumbnailator;

@Controller
public class AttachFileController {
	

	@RequestMapping(value ="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] gdsImg){
		
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "c:\\attach";
		
		String uploadFolderPath = getFolder();
		
		
		//make folder
		File uploadPath = new File(uploadFolder, uploadFolderPath);
	
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs(); //지정된 폴더가 존재하는 경우 여러개의 디렉토리 생성
		}
		
		for(MultipartFile multipartFile : gdsImg) {
			AttachFileDTO attachFileDTO = new AttachFileDTO();
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);
		
			attachFileDTO.setFileName(uploadFileName);
			
			//랜덤 숫자 생성
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);

				attachFileDTO.setFileId(uuid.toString());
				attachFileDTO.setUploadPath(uploadFolderPath);

				if(checkImageType(saveFile)) {
					
					//image가 맞을경우 섬네일 생성
					attachFileDTO.setImage("Y");
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath,"thumb_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail,300,300); //300*300사이즈
					thumbnail.close();		
				}
				list.add(attachFileDTO);
			} catch (Exception e) {
				System.out.println(e.getMessage());
			}//end catch
		}//end for
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	

	//파일 보여주기
	@RequestMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		File file = new File("c:\\attach\\"+fileName);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header,HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	//사진 및 파일 다운로드
	@RequestMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName){
		
		//attach파일 자체에 있어야 한다!
		Resource resource = new FileSystemResource("c:\\attach\\"+fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}

		String resourceName = resource.getFilename();

		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_")+1);
		
		HttpHeaders headers = new HttpHeaders();
		try {	
			//브라우저별 차이
			String downloadName = null;
			if(userAgent.contains("Trident")) {
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8").replaceAll("\\+", " ");
			}else if(userAgent.contains("Edge")){
				downloadName = URLEncoder.encode(resourceOriginalName,"UTF-8");
			} else {
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"),"ISO-8859-1");
			}
			headers.add("Content-Disposition", "attachment; filename="+downloadName);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	//파일 삭제
	@RequestMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type){
		File file = null;
		
		try {
			file = new File("c:\\attach\\"+URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			//이미지일 경우 섬네일도 삭제
			if(type.equals("image")) {
				String largeFileName = file.getAbsolutePath().replace("thumb_", "");
				file = new File(largeFileName);
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleteFile",HttpStatus.OK);
	}
	
	//폴더 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
		Date date = new Date();
			
		String str = sdf.format(date);
		return str.replace("-", File.separator); //windows : File.seperator(\\)
	}
	
	//파일이 image타입인지 확인
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());	
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
			return false;
		}

}
