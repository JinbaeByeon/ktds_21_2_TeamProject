package com.kpms.common.excel4j.util.read.share;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import com.kpms.common.excel4j.option.ReadOption;

public class ReadShare {

	public static Workbook wb;
	
	public static Sheet sheet;
	public static String sheetName;
	
	public static Row row;
	public static Cell cell;
	
	public static Class<?> clazz;
	
	public static int numOfRows;
	public static int numOfCells;
	
	public static ReadOption readOption;
}
