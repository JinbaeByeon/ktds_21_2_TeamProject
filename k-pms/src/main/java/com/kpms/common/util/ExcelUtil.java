package com.kpms.common.util;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kpms.common.excel4j.option.WriteOption;
import com.kpms.common.excel4j.write.ExcelWrite;
import com.kpms.common.handler.DownloadUtil;

public class ExcelUtil {
	
	public static <T> File writeExcel(List<T> contents
			, String fileName
			, String path) {
		WriteOption<T> wo = new WriteOption<T>();
		wo.setFileName(fileName);
		wo.setFilePath(path);

		wo.setContents(contents);

		return ExcelWrite.write(wo);
	}
	
}
