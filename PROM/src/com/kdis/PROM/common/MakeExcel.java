package com.kdis.PROM.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;

import net.sf.jxls.transformer.XLSTransformer;

/**
 * Excel 파일 생성
 */
public class MakeExcel {

	/**
	 * Excel 파일 생성
	 * 
	 * @param request HttpServletRequest
	 * @param response HttpServletResponse
	 * @param beans  Beans in a map under keys used in .xls template to access to the beans
	 * @param filename Excel 파일명
	 * @param templateFile Excel template 파일명
	 */
	public void download(HttpServletRequest request, HttpServletResponse response, Map<String, Object> beans,
			String filename, String templateFile) {
		String tempPath = request.getSession().getServletContext().getRealPath("/resources/excel");

		try {
			InputStream is = new BufferedInputStream(new FileInputStream(tempPath + File.separator + templateFile));
			XLSTransformer transformer = new XLSTransformer();
			Workbook resultWorkbook = transformer.transformXLS(is, beans);
			response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + ".xlsx\"");
			OutputStream os = response.getOutputStream();
			resultWorkbook.write(os);

		} catch (Exception ex) {
			System.out.println("error!");
		}
	}
}
