package com.kpms.common.excel4j.util.write;

public class FileType {

	public static boolean isXls(String fileName) {
		return fileName.toUpperCase().endsWith(ExcelExtentions.XLS);
	}
	
	public static boolean isXlsx(String fileName) {
		return fileName.toUpperCase().endsWith(ExcelExtentions.XLSX);
	}
	
}
