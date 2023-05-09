package com.kpms.common.excel4j.util.write;

import org.apache.poi.ss.usermodel.Row;

import com.kpms.common.excel4j.util.write.share.WriteShare;

public class MakeRow {

	public static Row create() {
		return create(WriteShare.rowIndex++, false);
	}
	
	public static Row create(int rowNum) {
		return create(rowNum, false);
	}
	
	public static Row create(int rowNum, boolean isCreateParentRow) {
		Row tempRow = WriteShare.sheet.getRow(rowNum);
		if(tempRow == null) {
			if ( isCreateParentRow ) WriteShare.rowIndex++;
			tempRow = WriteShare.sheet.createRow(rowNum);
		}
		
		return tempRow;
	}
	
}
