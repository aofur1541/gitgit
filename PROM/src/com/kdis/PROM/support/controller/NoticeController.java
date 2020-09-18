package com.kdis.PROM.support.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kdis.PROM.log.service.LogService;
import com.kdis.PROM.login.util.LoginSessionUtil;
import com.kdis.PROM.support.service.NoticeService;
import com.kdis.PROM.support.vo.NoticeVO;
import com.kdis.PROM.user.vo.UserVO;

/**
 * 고객 지원 > 공지 사항 Controller class
 * 
 * @author KimHahn
 *
 */
@Controller
public class NoticeController {
	
	private static final Log LOG = LogFactory.getLog(NoticeController.class);

	/** 공지사항 서비스 */
	@Autowired
	private NoticeService noticeService;
	
	/** 이력 service */
	@Autowired
	private LogService logService;
	/*
	 * // TODO 공지사항, 문의사항 화면이 iframe을 제거하고 각자 화면을 독립하면 삭제해야 한다.
	 * 
	 * @RequestMapping("menu/totalconfiguration.do") public ModelAndView
	 * totalconfiguration() { ModelAndView mav = new ModelAndView(); return mav; }
	 */
	
	/**
	 * 고객 지원 > 공지 사항 화면으로 이동
	 * 
	 * @return
	 */
	// TODO 새로운 화면 적용 이후에 /support/notice.do 로 변경해 줘야 함
	//@RequestMapping("/support/notice.do")
	@RequestMapping("/support/notice.prom")
	public String notice() {
		//return "/support/notice";
		return "/support/notice";
	}
	
	/**
	 * 고객 지원 > 공지 사항 등록 화면으로 이동
	 * 
	 * @return
	 */
	// TODO 새로운 화면 적용 이후에 /support/addNotice.do 로 변경해 줘야 함
	//@RequestMapping("/support/addNotice.do")
	@RequestMapping("/support/addNotice.prom")
	public ModelAndView addNotice() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("support/addNotice");
		return mav;
	}
	
	/**
	 * 공지 사항 상세 화면으로 이동
	 * 
	 * @param mv
	 * @param id
	 * @return
	 * @throws UnsupportedEncodingException 
	 */

	/*
	 * .do 사용 시 v1 UI가 나오는 현상 해결법
	 * .prom 으로 변경 (v1이 덜 걷혀서 v1에 연결된 css로 출력됨)
	 * v1 걷어낸 후에 다시 .do로 변경하거나 .prom을 화면이동할 때 URL용으로 분리해서 사용
	 */	
	
	@RequestMapping("/support/viewNotice.prom")
	public ModelAndView viewNotices(ModelAndView mv, int id) throws UnsupportedEncodingException {
		
		// 해당 공지 사항 정보 얻기
		NoticeVO viewNotice = noticeService.selectNotice(id);
		// 해당 공지 사항의 전 공지 사항 정보 얻기
		NoticeVO preNotice = noticeService.selectPreNotice(id);
		// 해당 공지 사항의 다음 공지 사항 정보 얻기
		NoticeVO nextNotice = noticeService.selectNextNotice(id);
		
		// 공지 사항 조회수 +1
		noticeService.increaseNoticeViewCount(id);
		
		// 본문 url 디코딩
		String decodedContents = URLDecoder.decode(viewNotice.getContents(), "UTF-8").replaceAll("\\%20", " ")
				.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
				.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
		viewNotice.setContents(decodedContents);
		
		mv.addObject("viewNotices", viewNotice);
		mv.addObject("getPre", preNotice);
		mv.addObject("getNext", nextNotice);
		
		// FIXME 새로운 화면 적용 이후에 /support/viewNotices 로 변경해 줘야 함
		mv.setViewName("/support/viewNotice");
		return mv;
	}
	
	/**
	 * 고객 지원 > 공지 사항 수정 화면으로 이동
	 * 
	 * @param mv
	 * @param id
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/support/editNotice.prom")
	public ModelAndView editNotice(ModelAndView mv, int id) throws UnsupportedEncodingException {
		
		// 공지 사항 정보 조회
		NoticeVO noticeVO = noticeService.selectNotice(id);
		
		LOG.debug("Contents : " + noticeVO.getContents());
		// URL 디코딩
		String decodedContents = URLDecoder.decode(noticeVO.getContents(), "UTF-8").replaceAll("\\%20", " ")
				.replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'").replaceAll("\\%28", "(")
				.replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
		LOG.debug("decodedContents : " + decodedContents);
		
		noticeVO.setContents(decodedContents);
		mv.addObject("notice", noticeVO);
		mv.setViewName("/support/editNotice");//FIXME 새로운 화면 적용 이후에 /support/editNotice 로 변경해 줘야 함
		
		return mv;
	}
	
	/**
	 * 공지 사항 목록 조회
	 * 
	 * @return
	 */
	@RequestMapping("/support/selectNoticeList.do")
	public @ResponseBody List<NoticeVO> selectNoticeList() {
		List<NoticeVO> result = noticeService.selectNoticeList();
		return result;
	}
	
	/**
	 * 이미지 파일을 임시 공간에 upload
	 * 
	 * 결과
	 * 1 : 성공
	 * 2 : 이미지 파일 아님
	 * 3 : 에러 발생
	 * 
	 * @param file
	 * @param number 0: 공지사항, 1:문의사항
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value = "/support/uploadImageFile.do", method = RequestMethod.POST)
	public Map<String, Object> uploadSummernote(MultipartFile file, int number) throws IOException {
		
		// 결과
		int result = 0;
		// 이미지 파일 url
		String tempPath = "";
		// 이미지 파일명
		String uuidName = "";
		
		// 결과 map
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			
			// 실제 파일명
			String orgFilename = file.getOriginalFilename();
			
			// 파일의 확장자 얻기
			int commaIndex = orgFilename.lastIndexOf(".");
			String fileExtension = orgFilename.substring(commaIndex + 1);
			
			// 이미지 파일(확장자:gif, jpg, jpeg, png)만 업로드 가능함
			if(!(fileExtension.toLowerCase().equals("gif") || fileExtension.toLowerCase().equals("jpg") || 
					fileExtension.toLowerCase().equals("png") || fileExtension.toLowerCase().equals("jpeg"))) {
				// 이미지 파일이 아닌 경우
				result = 2;
				
				map.put("tempPath", "");
				map.put("uuidName", "");
				map.put("result", result);
				
			} else {
				
				// tomcat 위치
				String catalina = System.getProperty("catalina.home");
				
				// 현재날짜
				String sysdate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
				
				// 서버에 저장될 파일명(램덤으로 생성된 문자열 .확장자)
				uuidName = UUID.randomUUID() + "." + fileExtension;
				
				// number(0: 공지사항, 1:문의사항)
				if (number == 0) {
					// 공지사항
					// 파일이 임시로 저장될 서버의 파일 경로 : tomcat 위치/attachedFile/noticesTemp/현재날짜/파일명
					String filepath = catalina + "/attachedFile/noticesTemp" + "/" + sysdate + "/" + uuidName;
					
					// 파일 생성
					File f = new File(filepath);
					
					// 파일이 없는 경우 디렉토리 생성
					if (!f.exists()) {
						f.mkdirs();
					}
					
					// 경로에 실제 파일 복사
					file.transferTo(f);
					
					// 웹에서 임시 파일에 접근 가능한 url 
					tempPath = "/img/attachedFile/noticesTemp/" + sysdate + "/" + uuidName;
					
					result = 1;
					
					map.put("tempPath", tempPath);
					map.put("uuidName", uuidName);
					map.put("result", 1);
					
				} else {
					// 문의사항
					// 파일이 임시로 저장될 서버의 파일 경로 : tomcat 위치/attachedFile/questionsTemp/현재날짜/파일명
					String filepath = catalina + "/attachedFile/questionsTemp" + "/" + sysdate + "/" + uuidName;
					
					// 파일 생성
					File f = new File(filepath);
					
					// 파일이 없는 경우 디렉토리 생성
					if (!f.exists()) {
						f.mkdirs();
					}
					
					// 경로에 실제 파일 복사
					file.transferTo(f);
					
					// 웹에서 임시 파일에 접근 가능한 url 
					tempPath = "/img/attachedFile/questionsTemp/" + sysdate + "/" + uuidName;
					
					result = 1;
				}
			}
		} catch (IllegalStateException e) {
			LOG.error(e);
			result = 3;
		} catch (IOException e) {
			LOG.error(e);
			result = 3;
			
		}
		map.put("tempPath", tempPath);
		map.put("uuidName", uuidName);
		map.put("result", result);
		
		return map;
	}
	
	/**
	 * 임시 공간에 있는 이미지 삭제
	 * 
	 * @param tempFilesName
	 */
	@ResponseBody
	@RequestMapping(value = "/support/deleteImageFile.do", method = RequestMethod.POST)
	public void deleteImageFile(String[] tempFilesName) {
		
		// tomcat 위치
		String catalina = System.getProperty("catalina.home");
		
		// 임시 저장된 이미지 파일 삭제
		if (tempFilesName != null && tempFilesName.length > 0) {
			for (int i = 0; i < tempFilesName.length; i++) {
				String deletePath = catalina + "/" + tempFilesName[i].replaceAll("/img/", "");
				File file = new File(deletePath);
				file.delete();
			}
		}
	}
	
	/**
	 * 공지 사항 등록
	 * 
	 * @param noticeVO
	 * @param session
	 * @throws UnsupportedEncodingException 
	 */
	@ResponseBody
	@RequestMapping(value = "/support/insertNotice.do", method = RequestMethod.POST)
	public void insertNotice(NoticeVO noticeVO, HttpSession session) throws UnsupportedEncodingException {
		
		String sysdate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		
		// tomcat 위치
		String catalina = System.getProperty("catalina.home");
		
		// 임시 저장 디렉토리
		String tempFolder = catalina + "/attachedFile/noticesTemp";
		
		// 정식 저장 디렉토리
		String imageFolder = catalina + "/attachedFile/images/" + sysdate;
		
		// 업로드한 이미지 파일를 임시 저장 공간에서 정식 저장 공간으로 이동시키기
		if(noticeVO.getTempFilesName() != null && noticeVO.getTempFilesName().length > 0) {
			for (int i = 0; i < noticeVO.getTempFilesName().length; i++) {
				
				if (!noticeVO.getContents().contains(noticeVO.getTempFilesName()[i])) {
					// 임시 파일이 실제 문의사항 본문에 포함 안된 경우에는 그냥 패스
					continue;
				}
				
				// 파일 url에서 파일명만 얻기
				String fileName = noticeVO.getTempFilesName()[i].replaceAll("img/attachedFile/noticesTemp/" + sysdate + "/", "");
				
				// 임시 파일 경로
				String tempPath = tempFolder + "/" + sysdate + fileName;
				
				// 정식 파일 경로
				String imagePath = imageFolder + fileName;
	
				try {
				
					File in = new File(tempPath);
					File out = new File(imagePath);
					File outFile = new File(imageFolder);
					
					// 정식 저장 디렉토리가 없는 경우에는 생성
					if (!outFile.exists()) {
						outFile.mkdirs();
					}
				
					// 이미지 파일을 임시 저장 공간에서 정식 공간으로 복사하고 임시 저장 공간의 파일을 삭제한다.
					// 파일 복사
					FileCopyUtils.copy(in, out);
					// 임시 파일 삭제
					in.delete();
					
				} catch (IOException e) {
					LOG.error(e);
				} 
			}
		}
		
		// 본문에 있는 이미지 파일의 url을 임시에서 정식으로 변경
		noticeVO.setContents(noticeVO.getContents().replaceAll("src=\"/img/attachedFile/noticesTemp",
				"src=\"/img/attachedFile/images"));
		// url 인코딩
		String encodedContents = URLEncoder.encode(noticeVO.getContents(), "UTF-8").replaceAll(" ", "\\%20")
					.replace("\\+", "\\%2B").replaceAll("\\!", "\\%21").replaceAll("\\'", "\\%27")
					.replaceAll("\\(", "\\%28").replaceAll("\\)", "\\%29").replaceAll("\\~", "\\%7E");
		noticeVO.setContents(encodedContents);
		
		// 공지사항 등록
		noticeService.insertNotice(noticeVO);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + noticeVO.getTitle() + "]" + " 작성";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "공지사항", "Create");
				
	}
	
	/**
	 * 공지사항 수정
	 * 
	 * @param noticeVO
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/support/updateNotice.do", method = RequestMethod.POST)
	public int updateNotice(NoticeVO noticeVO, HttpSession session) throws UnsupportedEncodingException {

		// 결과
		int result = 0;
		
		// DB에서 저장된 공지 사항 정보(원본)를 조회한다.
		NoticeVO dbNotice = noticeService.selectNotice(noticeVO.getId());
		
		// tomcat 위치
		String catalina = System.getProperty("catalina.home");
		
		// 업로드한 이미지 파일를 임시 저장 공간에서 정식 저장 공간으로 이동시키기
		if(noticeVO.getTempFilesName() != null && noticeVO.getTempFilesName().length > 0) {
			for (int i = 0; i < noticeVO.getTempFilesName().length; i++) {
		
				if (!noticeVO.getContents().contains(noticeVO.getTempFilesName()[i])) {
					// 임시 파일이 실제 문의사항 본문에 포함 안된 경우에는 그냥 패스
					continue;
				}
				
				// 임시 파일 경로
				String tempPath = noticeVO.getTempFilesName()[i].replace("/img/attachedFile/noticesTemp/",
						catalina + "/attachedFile/noticesTemp/");
				
				// 정식 파일 경로
				String imagePath = noticeVO.getTempFilesName()[i].replace("/img/attachedFile/noticesTemp/",
						catalina + "/attachedFile/images/");
				
				// 정식 파일의 디렉토리 경로
				String folder = imagePath.substring(0, imagePath.lastIndexOf("/"));
				
				try {
					
					File inFile = new File(tempPath);
					File outFile = new File(imagePath);
					File folderFile = new File(folder);
					
					// 정식 저장 디렉토리가 없는 경우에는 생성
					if (!folderFile.exists()) {
						folderFile.mkdirs();
					}
					
					// 이미지 파일을 임시 저장 공간에서 정식 공간으로 복사하고 임시 저장 공간의 파일을 삭제한다.
					// 파일 복사
					FileCopyUtils.copy(inFile, outFile);
					
					// 임시 파일 삭제
					inFile.delete();
					
				} catch (IOException e) {
					LOG.error(e);
				}
			}
		}
		
		// 에디터에 삭제한 이미지를 물리적 파일도 삭제한다.
		if(noticeVO.getTempDeleteName() != null && noticeVO.getTempDeleteName().length > 0) {
			for (int i = 0; i < noticeVO.getTempDeleteName().length; i++) {
				
				LOG.debug("TempDeleteName : " + noticeVO.getTempDeleteName()[i]);
				
				// 삭제된 이미지 파일을 물리적으로도 삭제한다.
				// 정식 파일 경로
				String deleteImagePath = noticeVO.getTempDeleteName()[i].replace("/img/attachedFile/images/",
						catalina + "/attachedFile/images/");
				
				LOG.debug("deleteImagePath : " + noticeVO.getTempDeleteName()[i]);
				
				File deleteFile = new File(deleteImagePath);
				deleteFile.delete();
			}
		}
			
		// 본문에 있는 이미지 파일의 url을 임시에서 정식으로 변경
		noticeVO.setContents(noticeVO.getContents().replaceAll("src=\"/img/attachedFile/noticesTemp",
			"src=\"/img/attachedFile/images"));
		
		// 본문 url 인코딩
		String encodedContents = URLEncoder.encode(noticeVO.getContents(), "UTF-8").replaceAll(" ", "\\%20")
				.replace("\\+", "\\%2B").replaceAll("\\!", "\\%21").replaceAll("\\'", "\\%27")
				.replaceAll("\\(", "\\%28").replaceAll("\\)", "\\%29").replaceAll("\\~", "\\%7E");
		noticeVO.setContents(encodedContents);
		
		// 공지 사항 수정
		result = noticeService.updateNotice(noticeVO);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "";
		if(dbNotice.getTitle().equals(noticeVO.getTitle())) {
			sContext = "[" + dbNotice.getTitle() + "]";
		} else {
			sContext = "[" + dbNotice.getTitle() + "]" + " -> " + noticeVO.getTitle();
		}
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "공지사항", "Update");
		
		return result;
	}
	
	/**
	 * 공지사항 삭제
	 * 
	 * @param id
	 * @param session
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@ResponseBody
	@RequestMapping(value = "/support/deleteNotice.do", method = RequestMethod.POST)
	public int deleteNotice(int id, HttpSession session) throws UnsupportedEncodingException {
		
		// 결과
		int result = 0;
		
		// tomcat 위치
		String catalina = System.getProperty("catalina.home");
		
		// DB에서 저장된 공지 사항 정보(원본)를 조회한다.
		NoticeVO dbNotice = noticeService.selectNotice(id);
		
		// 본문에 이미지가 첨부가 있는 경우에 본문에서 첨부된 이미지 파일명을 얻는다.
		// 본문 url 디코딩
		String encodedDBContents = URLDecoder.decode(dbNotice.getContents(), "UTF-8")
				.replaceAll("\\%20", " ").replace("\\%2B", "+").replaceAll("\\%21", "!").replaceAll("\\%27", "'")
				.replaceAll("\\%28", "(").replaceAll("\\%29", ")").replaceAll("\\%7E", "~");
		dbNotice.setContents(encodedDBContents);
				
		// DB 원본의 이미지 파일명 목록 얻기
		List<String> dbImageFileList = this.getImageFileListFromContents(dbNotice.getContents());
		
		for (int i = 0; i < dbImageFileList.size(); i++) {
			// 삭제된 이미지 파일을 물리적으로도 삭제한다.
			String deletePath = dbImageFileList.get(i).replace("src=\"/img", catalina);
			File deleteFile = new File(deletePath);
			deleteFile.delete();
		}
		
		// 공지사항 삭제
		result = noticeService.deleteNotice(id);
		
		// 로그 기록
		// 로그인 정보 얻기
		UserVO loginInfo = LoginSessionUtil.getLoginInfo(session);
		
		String sContext = "[" + dbNotice.getTitle() + "]" + " 삭제";
		logService.insertLog(loginInfo.getsUserID(), 0, sContext, "공지사항", "Delete");
		
		return result;
	}
	
	/**
	 * 본문에서 첨부된 이미지 파일 목록을 얻는다.
	 * 
	 * @param contents
	 * @return
	 */
	private List<String> getImageFileListFromContents(String contents) {
		
		ArrayList<String> fileList = new ArrayList<String>();
		int fileStartIndex = 0;
		int fileEndIndex = 0;
		
		// 본문에 이미지가 첨부가 있는 경우에 본문에서 첨부된 이미지 파일명을 얻는다.
		if (contents != null && contents.length() > 0 && 
				contents.indexOf("src=\"/img/attachedFile") > -1) {
			
			do {
				// 이미지 파일 위치를 찾고 반복문으로 찾았던 위치 다음에서 또 이미지 파일이 있는지 찾는다.
				fileStartIndex = contents.indexOf("src=\"/img/attachedFile", fileStartIndex + 1);
				fileEndIndex = contents.indexOf("\" style=", fileStartIndex + 1);
				if (fileStartIndex != -1) {
					contents.substring(fileStartIndex, fileEndIndex);

					fileList.add(contents.substring(fileStartIndex, fileEndIndex));
				}
			// 	이미지 파일이 더이상 없을 때까지 반복
			} while (fileStartIndex + 1 < contents.length() && fileStartIndex > -1);	
		}
		return fileList;
	}
	
}
