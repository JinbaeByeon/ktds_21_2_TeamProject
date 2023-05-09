package com.kpms.common.excel4j.util.read;

import com.kpms.common.excel4j.util.read.share.ReadShare;

public class GetRow {

	public static void setRow(int rowIndex) {
		ReadShare.row = ReadShare.sheet.getRow(rowIndex);
	}
	
	public static boolean isNotNull() {
		return ReadShare.row != null;
	}
	
	public static void setPhysicalNumberOfCells() {
		ReadShare.numOfCells = ReadShare.row.getPhysicalNumberOfCells();
	}
	
}
