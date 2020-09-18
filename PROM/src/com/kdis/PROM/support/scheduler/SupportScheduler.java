package com.kdis.PROM.support.scheduler;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.attribute.BasicFileAttributes;
import java.time.LocalDate;
import java.util.concurrent.TimeUnit;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

/**
 * 고객지원 스케쥴러
 * 
 * 오전 4시에 어제 업로드된  공지사항/문의사항에 임시 이미지 파일을 삭제한다.
 * 
 * @author KimHahn
 *
 */
@Service
public class SupportScheduler {

	private static final Log LOG = LogFactory.getLog(SupportScheduler.class);

	/**
	 * 마지막으로 수정한지 1시간이 지난 파일 지정
	 */
	private static final int DELETE_SEC = 3600; 
	
	/**
	 * 오전 4시에 어제 업로드된  공지사항/문의사항에 임시 이미지 파일을 삭제한다.
	 * 
	 * @throws Exception
	 */
	//@Scheduled(fixedDelay = 60000)//테스트용(1분마다 실행) 
	@Scheduled(cron="0 0 04 * * ?")//오전 4시에 실행
	public void deleteTempImageFile() throws Exception {
		// 공지사항
		deleteTempImageFile(DELETE_SEC, "/attachedFile/noticesTemp/");
		// 문의사항
		deleteTempImageFile(DELETE_SEC, "/attachedFile/questionsTemp/");
	}
	
	/**
	 * 어제 업로드된 임시 이미지 파일 중에서 마지막으로 수정한지 1시간이 지난 파일을 삭제한다.
	 * 
	 * @param sec
	 */
	private void deleteTempImageFile(int sec, String path) {
		
		LocalDate today = LocalDate.now();
		
		// tomcat 위치
		String catalina = System.getProperty("catalina.home");
		
		// 어제 업로드된 이미지 파일 경로
		String folder = catalina + path + today.minusDays(1);
		LOG.debug(folder);
		
		File files = new File(folder);
		
		// 디렉토리 유무 확인
		if (files.exists()) {
			// 디렉토리가 있는 경우에는 파일 목록을 얻는다.
			for (File f : files.listFiles()) {
				if (files == null) {
					continue;
				}
				try {
					// 마지막으로 파일 수정을 한지 얼마나 지난지는 시간 얻기
					long secondsFromModification = this.getSecondsFromModification(f);
					
					// 마지막으로 파일 수정하고 지난 시간이 지정한 시간보다 클 경우에는 파일을 삭제한다.
					if (secondsFromModification > sec) {
						LOG.warn("temp file delete : " + f.getAbsolutePath() + "  modify time(s) : " + secondsFromModification);
						f.delete();
					}
				} catch (IOException e) {
					LOG.error(e);
				}
			}
		}
	}
	
	/**
	 * 마지막으로 파일 수정을 한지 얼마나 지난지는 시간 얻기(단위: 초)
	 * 
	 * @param f
	 * @return
	 * @throws IOException
	 */
	private long getSecondsFromModification(File f) throws IOException {
		Path attribPath = f.toPath();
		BasicFileAttributes basicAttribs = Files.readAttributes(attribPath, BasicFileAttributes.class);
		return (System.currentTimeMillis() - basicAttribs.lastModifiedTime().to(TimeUnit.MILLISECONDS)) / 1000;
	}
}
